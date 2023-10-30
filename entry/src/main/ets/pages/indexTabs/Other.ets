import hilog from '@ohos.hilog'
@Entry
@Component
struct OtherComponent {
  private dialogController: CustomDialogController = new CustomDialogController({builder: MyDialog(), cancel: () => {
    hilog.info(0x0001, "dialog", "点外界消失的回调")
  }, alignment: DialogAlignment.Center, customStyle: true})

  build() {
    Column() {
      SwiperBanner()
        .width("90%")
        .height(100)
        .backgroundColor("#000000")
      Text("打开弹框")
        .fontColor("#FFFFFF")
        .backgroundColor("#006633")
        .borderRadius(4)
        .padding(10)
        .onClick(() => {
          this.dialogController.open()
        })
    }.width("100%")
    .height("100%")
  }
}

@Component
struct SwiperBanner {
  build() {
    Swiper() {
      Text("0")
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Gray)
        .textAlign(TextAlign.Center)
        .fontSize(30)

      Text("1")
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Green)
        .textAlign(TextAlign.Center)
        .fontSize(30)

      Text("2")
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Blue)
        .textAlign(TextAlign.Center)
        .fontSize(30)

      Text("3")
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Brown)
        .textAlign(TextAlign.Center)
        .fontSize(30)

      Text("4")
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Grey)
        .textAlign(TextAlign.Center)
        .fontSize(30)

      Text("5")
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Orange)
        .textAlign(TextAlign.Center)
        .fontSize(30)
    }
    .loop(true)
    .autoPlay(true)
    .interval(1500)
    .displayCount(3)
    .cachedCount(2)
  }
}

// 弹框
@CustomDialog
struct MyDialog {
  private dialogController: CustomDialogController

  build() {
    Column() {
      Column() {
        Text('我是内容')
          .fontSize(20)
          .margin({ top: 10, bottom: 10 })
        Row() {
          Text("取消")
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              hilog.info(0x0001, "dialog", "点击了取消")
              this.dialogController.close()
            })
          Text("确认")
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              hilog.info(0x0001, "dialog", "点击了确认")
              this.dialogController.close()
            })
        }.margin(10)
      }
      .backgroundColor("#FFFFFF")
      .borderColor("#FF0000")
      .borderWidth(1)
    }
    .width("100%")
    .padding({left: 10, right: 10})
  }
}

export default OtherComponent