import router from '@ohos.router'

@Entry
@Component
struct Splash {
  timer: number = null

  build() {
    Column() {
      Text("启动页")
        .fontColor($r("app.color.color_46C378"))
        .fontSize(40)
        .backgroundColor($r("app.color.color_FFFFFF"))
    }
    .backgroundColor($r("app.color.color_46C378"))
    .width("100%")
    .height("100%")
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  aboutToAppear() {
    // 定时3秒后跳转
    console.log("开始定时")
    this.timer = setTimeout(this.gotoNextPage.bind(this), 3000, [])
  }

  aboutToDisappear() {
    console.log("销毁组件")
    clearTimeout(this.timer)
  }

  private gotoNextPage() {
    console.log("倒计时结束，进入下一个页面")
    clearTimeout(this.timer)
    router.replaceUrl({
      url: "pages/Login"
    })
  }
}