import router from '@ohos.router'
import TaskComponent from "./indexTabs/Task"
import OtherComponent from "./indexTabs/Other"

@Entry
@Component
struct Index {
  @State isLeft: boolean = true
  @State currentChooseTab: IndexTabs = IndexTabs.task

  aboutToAppear() {
    console.log(`login, index clear之前: ${router.getLength()}`)
    router.clear()
    console.log(`login, index clear之后: ${router.getLength()}`)
    setTimeout(() => {
      console.log(`login, index clear， 延时1秒之后: ${router.getLength()}`)
    }, 1000)
  }

  build() {
    SideBarContainer(SideBarContainerType.Overlay) {
      // 抽屉内容
      if (this.isLeft) {
        Column() {
        }
        .width("100%")
        .height("100%")
        .backgroundColor("#ff0000")
      } else {
        Row() {
        }
        .width("100%")
        .height("100%")
        .backgroundColor("#ffFF00")
      }
      // 主要内容
      Column() {
        Row() {
          if (this.currentChooseTab === IndexTabs.task) {
            TaskComponent()
            // .onClick(() => {
            //   this.isLeft = !this.isLeft
            // })
          } else if (this.currentChooseTab === IndexTabs.others) {
            OtherComponent()
          }
        }
        .width("100%")
        .layoutWeight(1)

        IndexBottomTabs({ chooseTab: this.currentChooseTab })
      }
      .width('100%')
    }
    .showSideBar(false)
    .sideBarPosition(this.isLeft ? SideBarPosition.Start : SideBarPosition.End) // 可以动态切换位置
    .sideBarWidth(200)
    .minSideBarWidth(200)
    .maxSideBarWidth(280)
    .controlButton({
      left: 15,
      top: 15
    })
  }
}

enum IndexTabs {
  task,
  others,
  workbench,
  mine
}

@Component
struct IndexBottomTabs {
  @Link chooseTab: IndexTabs

  build() {
    Row() {
      Column() {
        Image("")
          .tabImgStyle(IndexTabs.task, this.chooseTab)
        Text("待办")
          .tabTextStyle(IndexTabs.task, this.chooseTab)
      }.tabColStyle()
      .onClick(() => {
        this.chooseTab = IndexTabs.task
      })

      Column() {
        Image("")
          .tabImgStyle(IndexTabs.others, this.chooseTab)
        Text("其他")
          .tabTextStyle(IndexTabs.others, this.chooseTab)
      }.tabColStyle()
      .onClick(() => {
        this.chooseTab = IndexTabs.others
      })

      Blank()
        .height("100%")
        .layoutWeight(1)

      Column() {
        Image("")
          .tabImgStyle(IndexTabs.workbench, this.chooseTab)
        Text("工作台")
          .tabTextStyle(IndexTabs.workbench, this.chooseTab)
      }.tabColStyle()
      .onClick(() => {
        this.chooseTab = IndexTabs.workbench
      })

      Column() {
        Image("")
          .tabImgStyle(IndexTabs.mine, this.chooseTab)
        Text("我的")
          .tabTextStyle(IndexTabs.mine, this.chooseTab)
      }.tabColStyle()
      .onClick(() => {
        this.chooseTab = IndexTabs.mine
      })
    }.width("100%")
    .height(50)
    .backgroundColor($r("app.color.color_FFFFFF"))
  }
}

@Extend(Column) function tabColStyle() {
  .height("100%")
  .layoutWeight(1)
  .alignItems(HorizontalAlign.Center)
  .justifyContent(FlexAlign.SpaceEvenly)
}

@Extend(Image) function tabImgStyle(self: IndexTabs, choose: IndexTabs) {
  .width(20)
  .height(20)
  .backgroundColor(self === choose ? $r("app.color.color_46C378") : $r("app.color.color_1A1D1B"))
}

@Extend(Text) function tabTextStyle(self: IndexTabs, choose: IndexTabs) {
  .fontColor(self === choose ? $r("app.color.color_46C378") : $r("app.color.color_1A1D1B"))
  .fontSize(10)
  .fontWeight(FontWeight.Medium)
}