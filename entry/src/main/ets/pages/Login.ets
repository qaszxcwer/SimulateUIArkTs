@Entry
@Component
struct Login {
  @State currentStep: LoginStep = LoginStep.InputPhone

  build() {
    Column() {
      if (this.currentStep === LoginStep.InputPhone) {
        Login_PhoneNum()
      } else if (this.currentStep === LoginStep.InputPassword) {
        Login_Pwd()
      } else {
        Login_Captcha()
      }
    }
  }
}

enum LoginStep {
  InputPhone,
  InputPassword,
  CaptchaLogin
}

@Component
struct Login_PhoneNum {
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
      TextInput({ placeholder: $r("app.string.pleaseInputPhoneNum") })
        .backgroundColor($r("app.color.color_FFFFFF"))
        .margin({ left: 24, top: 48 })
        .padding(0)
      Line().width("100%").height(1)
        .backgroundColor($r("app.color.color_1A1D1B"))
        .margin(15)
    }.width("100%")
    .height("100%")
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct Login_Pwd {
  build() {
    Text("密码")
  }
}

@Component
struct Login_Captcha {
  build() {
    Text("验证码")
  }
}