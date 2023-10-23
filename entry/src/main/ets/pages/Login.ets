import Prompt from '@system.prompt'
import router from '@ohos.router'

enum LoginStep {
  InputPhone,
  InputPassword,
  CaptchaLogin
}

function loginSuccess() {
  router.pushUrl({
    url: "pages/Index"
  })
}

let localStorage = new LocalStorage()
let KeyLoginStep = "KeyLoginStep"
localStorage.setOrCreate(KeyLoginStep, LoginStep.InputPhone)

@Entry(localStorage)
@Component
struct Login {
  @LocalStorageLink("KeyLoginStep") currentStep: LoginStep = LoginStep.InputPhone
  @State phoneNumber: string = ""

  build() {
    Column() {
      if (this.currentStep === LoginStep.InputPhone) {
        Login_PhoneNum({ phoneNum: this.phoneNumber })
      } else if (this.currentStep === LoginStep.InputPassword) {
        Login_Pwd({ phoneNum: this.phoneNumber })
      } else {
        Login_Captcha({ phoneNum: this.phoneNumber })
      }
    }
  }
}

@Component
struct Login_PhoneNum {
  @State private isAgree: boolean = false
  @Link private phoneNum: string
  @State private showPolicyPopup: boolean = false
  @State private isNextEnable: boolean = false
  @LocalStorageLink("KeyLoginStep") loginStep: LoginStep = LoginStep.InputPhone

  private getImage() {
    return this.isAgree ? $r("app.media.icon") : "https://fanyi.youdao.com/img/logo.50fdfa99.png"
  }

  private onClickAgree() {
    console.log("login, 同意协议")
    this.isAgree = !this.isAgree
    this.checkNextEnable()
  }

  private onPopupStateChange(event) {
    this.showPolicyPopup = event.isVisible
    console.log(`login, onPopupStateChange, isVisible = ${event.isVisible}, showPolicyPopup = ${this.showPolicyPopup}`)
  }

  private onChangePhoneNum(phone: string) {
    this.phoneNum = phone
    this.checkNextEnable()
  }

  private checkNextEnable() {
    this.isNextEnable = this.isAgree && (this.phoneNum.length == 11)
  }

  private onClickNext() {
    console.log(`login, isAgree = ${this.isAgree}, showPolicyPopup = ${this.showPolicyPopup}`)
    console.log(`login, phoneNum = ${this.phoneNum}`)
    if (!this.isAgree) {
      this.showPolicyPopup = true
      return
    }
    if (!this.isNextEnable) {
      return
    }
    console.log("login, 下一个步骤" + `, loginStep = ${this.loginStep}, localStorage = ${localStorage.prop("KeyLoginStep")
      .get()}`)
    this.loginStep = LoginStep.InputPassword
    console.log("login, 赋值之后" + `, loginStep = ${this.loginStep}, localStorage = ${localStorage.prop("KeyLoginStep")
      .get()}`)
    console.log("login, " + `localStorage size = ${localStorage.size()}, keys = ${localStorage.keys().next().value}`)
  }

  build() {
    Column() {
      Image("https://fanyi.youdao.com/img/logo.50fdfa99.png")
        .width("30%")
        .backgroundColor($r("app.color.color_46C378"))
        .margin({ left: 24, top: 48 })
      Text($r("app.string.login"))
        .fontColor($r("app.color.color_1A1D1B"))
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .margin({ left: 24, top: 48 })
      Stack({ alignContent: Alignment.End }) {
        TextInput({ placeholder: $r("app.string.pleaseInputPhoneNum"), text: this.phoneNum })
          .backgroundColor($r("app.color.color_FFFFFF"))
          .margin({ left: 24 })
          .padding(0)
          .type(InputType.PhoneNumber)
          .width("100%")
          .onChange(this.onChangePhoneNum.bind(this))

        Text("X")
          .fontColor($r("app.color.color_1A1D1B"))
          .backgroundColor($r("app.color.color_46C378"))
          .fontSize(20)
          .margin({ right: 24 })
          .onClick(() => {
            this.phoneNum = ""
          })
      }
      .margin({ top: 48 })

      Column() {
        Line().width("100%").height(1)
          .backgroundColor($r("app.color.color_1A1D1B"))
      }.width("100%")
      .padding({ left: 15, top: 15, right: 15 })

      Row() {
        Image(this.getImage())
          .width(20)
          .height(20)
            // .objectFit(ImageFit.Contain)
          .backgroundColor($r("app.color.color_46C378"))
          .onClick(this.onClickAgree.bind(this))
          .bindPopup(this.showPolicyPopup, {
            message: "请阅读并同意相关服务协议",
            onStateChange: this.onPopupStateChange.bind(this)
          })
        Text() {
          Span($r("app.string.iHaveReadAndAgree"))
          Span($r("app.string.servicePolicy"))
            .fontColor($r("app.color.color_46C378"))
            .fontSize(13)
            .onClick(() => {
              console.log("login, 协议1")
              Prompt.showToast({ message: "点击了协议1" })
            })
          Span($r("app.string.and"))
          Span($r("app.string.privacyPolicy"))
            .fontColor($r("app.color.color_46C378"))
            .fontSize(13)
            .onClick(() => {
              console.log("login, 协议2")
              Prompt.showToast({ message: "点击了协议2" })
            })
        }.fontSize(13)
        .fontColor($r("app.color.color_878787"))
        .margin({ left: 7 })
      }.padding({ left: 24, top: 18, right: 24 })

      Row() {
        Button($r("app.string.nextStep"), { type: ButtonType.Capsule })
          .width("100%")
          .backgroundColor(this.isNextEnable ? $r("app.color.color_46C378") : $r("app.color.color_A4A4A4"))
          .onClick(this.onClickNext.bind(this))
      }.width("100%")
      .padding({ left: 15, top: 60, right: 15 })

      Text($r("app.string.registerNewAccount"))
        .alignSelf(ItemAlign.Center)
        .fontColor($r("app.color.color_46C378"))
        .margin({ top: 24 })
        .onClick(() => {
          console.log("login, 注册账号")
          Prompt.showToast({ message: "点击了注册账号，清空输入框" })
          // 可以控制这个单方面操作输入框的内容，但是输入框的内容要反向同步给这个变量只能通过赋值的形式
          this.phoneNum = ""
        })

    }.width("100%")
    .height("100%")
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct Login_Pwd {
  @LocalStorageLink("KeyLoginStep") loginStep: LoginStep = LoginStep.InputPhone
  @Prop phoneNum: string
  @State loginPwd: string = ""

  private changePwd(password: string) {
    this.loginPwd = password
  }

  private onClickLogin() {
    if (this.loginPwd.length <= 0) {
      return
    }
    console.log("login, " + `以手机号: ${this.phoneNum}, 密码: ${this.loginPwd}进行登录`)
    loginSuccess()
  }

  build() {
    Column() {
      Text("返回")
        .onClick(() => {
          this.loginStep = LoginStep.InputPhone
        })
        .margin({ left: 24, top: 10 })
      Text("输入密码")
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor($r("app.color.color_1A1D1B"))
        .margin({ left: 24, top: 36 })

      Stack({ alignContent: Alignment.End }) {
        TextInput({ placeholder: "请输入登录密码", text: this.loginPwd })
          .backgroundColor($r("app.color.color_FFFFFF"))
          .padding(0)
          .fontSize(16)
          .type(InputType.Password)
          .width("100%")
          .onChange(this.changePwd.bind(this))
      }
      .margin({ top: 48, left: 24, right: 24 })

      Column() {
        Line().width("100%").height(1)
          .backgroundColor($r("app.color.color_1A1D1B"))
      }.width("100%")
      .padding({ left: 15, top: 15, right: 15 })

      Text("忘记密码")
        .alignSelf(ItemAlign.End)
        .margin({ top: 14, right: 25 })

      Row() {
        Button("登录", { type: ButtonType.Capsule })
          .width("100%")
          .onClick(this.onClickLogin.bind(this))
          .backgroundColor(this.loginPwd.length > 0 ? $r("app.color.color_46C378") : $r("app.color.color_A4A4A4"))
      }
      .margin({ left: 15, top: 135, right: 15 })

      Text("验证码登录 >")
        .alignSelf(ItemAlign.Center)
        .margin({ top: 24 })
        .fontColor($r("app.color.color_46C378"))
        .onClick(() => {
          this.loginStep = LoginStep.CaptchaLogin
        })
    }
    .alignItems(HorizontalAlign.Start)
    .width("100%")
  }
}

@Component
struct Login_Captcha {
  @LocalStorageLink("KeyLoginStep") loginStep: LoginStep = LoginStep.InputPhone
  @Prop phoneNum: string
  @State captcha: string = ""

  private getPhoneNumShow() {
    let countryCode = "+86"
    let phoneStars = "**** **"
    let phoneStart = this.phoneNum.slice(0, 3)
    let phoneEnd = this.phoneNum.slice(9, 11)
    return `${countryCode} ${phoneStart}${phoneStars}${phoneEnd}`
  }

  private onChangeCaptcha(code: string) {
    this.captcha = code
    if (this.captcha.length === 6) {
      console.log(`login, 以手机号: ${this.phoneNum}，验证码: ${this.captcha} 进行登录`)
      loginSuccess()
    }
  }

  private timer
  @State private times: number = 0
  private startCountDown() {
    this.times = 10
    this.timer = setInterval(this.everyCount.bind(this), 1000, [])
  }

  private everyCount(s: any[]) {
    console.log(`login, s: ${s}`)
    this.times--
    if (this.times <= 0) {
      this.stopCountDown()
    }
  }

  private stopCountDown() {
    clearInterval(this.timer)
  }

  aboutToAppear() {
    this.startCountDown()
  }

  aboutToDisappear() {
    this.stopCountDown()
  }

  build() {
    Column() {
      Text("返回")
        .onClick(() => {
          this.loginStep = LoginStep.InputPhone
        })
        .margin({ left: 24, top: 10 })
      Text("输入手机验证码")
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor($r("app.color.color_1A1D1B"))
        .margin({ left: 24, top: 36 })

      Text() {
        Span("已成功向手机号 ")
        Span(this.getPhoneNumShow())
        Span(" 发送短信验证码\n有效期为10分钟，请及时输入(随便输入6位数)")
      }
      .fontSize(13)
      .fontWeight(FontWeight.Normal)
      .fontColor($r("app.color.color_878787"))
      .margin({ left: 24, top: 12 })

      Row() {
        TextInput({ placeholder: "请输入短信验证码", text: this.captcha})
          .backgroundColor($r("app.color.color_FFFFFF"))
          .padding(0)
          .fontSize(16)
          .type(InputType.Number)
          .width("100%")
          .height(45)
          .textAlign(TextAlign.Center)
          .maxLength(6)
          .borderColor($r("app.color.color_46C378"))
          .borderWidth(1)
          .onChange(this.onChangeCaptcha.bind(this))
      }
      .padding({ top: 34, left: 24, right: 24 })

      Row() {
        Row() {
          Text(this.times <= 0 ? "发送验证码" : `${this.times}s后可重新获取短信验证码`)
            .fontColor(this.times <= 0 ? $r("app.color.color_46C378") : $r("app.color.color_1A1D1B"))
            .onClick(() => {
              if (this.times > 0) {
                return
              }
              this.startCountDown()
            })
            .layoutWeight(1)
          Text("密码登录 >")
            .fontColor($r("app.color.color_46C378"))
            .onClick(() => {
              this.loginStep = LoginStep.InputPassword
            })
        }.width("100%")
      }
      .width("100%")
      .padding({ left: 24, top: 24, right: 24 })
    }
    .alignItems(HorizontalAlign.Start)
    .width("100%")
  }
}