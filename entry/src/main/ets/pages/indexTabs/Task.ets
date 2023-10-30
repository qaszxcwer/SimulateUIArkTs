import http from '@ohos.net.http'
import BasicDataSource from '../../bean/BasicDataSource'

// @Entry
@Component
struct TaskComponent {
  build() {
    Column() {
      TaskHead()
      TaskFoot()
    }.width("100%")
    .height("100%")
    .backgroundColor($r("app.color.color_F3F3F3"))
  }
}

@Component
struct TaskHead {
  build() {
    RelativeContainer() {
      Row().backgroundColor($r("app.color.color_46C378"))
        .height(196)
        .id("bg")
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          right: { anchor: "__container__", align: HorizontalAlign.End }
        })

      RelativeContainer() {
        Image("")
          .backgroundColor("#000000")
          .width(15)
          .height(15)
          .id("more")
          .alignRules({
            left: { anchor: "__container__", align: HorizontalAlign.Start },
            center: { anchor: "__container__", align: VerticalAlign.Center }
          })
          .margin({ left: 15 })
        Text("我的待办")
          .fontColor($r("app.color.color_FFFFFF"))
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .alignSelf(ItemAlign.Center)
          .id("Title")
          .alignRules({
            center: { anchor: "__container__", align: VerticalAlign.Center },
            middle: { anchor: "__container__", align: HorizontalAlign.Center }
          })
      }
      .width("100%")
      .height(44)
      .id("TitleBar")
      .alignRules({
        top: { anchor: "__container__", align: VerticalAlign.Top },
        left: { anchor: "__container__", align: HorizontalAlign.Start },
        right: { anchor: "__container__", align: HorizontalAlign.End }
      })

      Row() {
        Column() {
          Text("待处理任务")
            .fontColor($r("app.color.color_FFFFFF"))
            .fontSize(11)
          Row() {
            Text("15")
              .fontColor($r("app.color.color_FFFFFF"))
              .fontSize(44)
              .fontWeight(FontWeight.Bold)
            Text("个")
              .fontColor($r("app.color.color_FFFFFF"))
              .fontSize(14)
          }.alignItems(VerticalAlign.Bottom)
        }

        Column() {
          Text("待处理审批")
            .fontColor($r("app.color.color_FFFFFF"))
            .fontSize(11)
          Row() {
            Text("4")
              .fontColor($r("app.color.color_FFFFFF"))
              .fontSize(44)
              .fontWeight(FontWeight.Bold)
            Text("个")
              .fontColor($r("app.color.color_FFFFFF"))
              .fontSize(14)
          }.alignItems(VerticalAlign.Bottom)
        }
      }.width("100%")
      .justifyContent(FlexAlign.SpaceEvenly)
      .id("rowCenterNum")
      .alignRules({
        top: { anchor: "TitleBar", align: VerticalAlign.Bottom },
        bottom: { anchor: "taskType", align: VerticalAlign.Top }
      })

      Row() {
        TaskType({ type: TaskTypeEnum.Today, taskNum: 2 }).layoutWeight(1)
        Line().width(1).height("100%").backgroundColor($r("app.color.color_DCDCDC"))
        TaskType({ type: TaskTypeEnum.OutTime, taskNum: 4 }).layoutWeight(1)
        Line().width(1).height("100%").backgroundColor($r("app.color.color_DCDCDC"))
        TaskType({ type: TaskTypeEnum.Normal, taskNum: 13 }).layoutWeight(1)
      }
      .width("100%")
      .backgroundColor($r("app.color.color_FFFFFF"))
      .height(72)
      .margin({ left: 15, right: 15, bottom: 15 })
      .borderRadius(12)
      .id("taskType")
      .alignRules({
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
        left: { anchor: "__container__", align: HorizontalAlign.Start },
        right: { anchor: "__container__", align: HorizontalAlign.End }
      })
    }.width("100%")
    .height(252)
  }
}

enum TaskTypeEnum {
  Today,
  OutTime,
  Normal
}

@Component
struct TaskType {
  private type: TaskTypeEnum
  @State private taskNum: number = 0

  private getTypeText(): string {
    if (this.type === TaskTypeEnum.Today) {
      return "今日到期"
    } else if (this.type === TaskTypeEnum.OutTime) {
      return "已超时"
    } else if (this.type === TaskTypeEnum.Normal) {
      return "正常进行"
    } else {
      return ""
    }
  }

  build() {
    Row() {
      RelativeContainer() {
        Image("")
          .width(25)
          .height(25)
          .backgroundColor("#000000")
          .id("img")
          .alignRules({
            top: { anchor: "__container__", align: VerticalAlign.Top },
            left: { anchor: "__container__", align: HorizontalAlign.Start }
          })

        Text(this.getTypeText())
          .fontColor($r("app.color.color_1A1D1B"))
          .fontSize(12)
          .id("typeText")
          .alignRules({
            top: { anchor: "img", align: VerticalAlign.Top },
            bottom: { anchor: "img", align: VerticalAlign.Bottom },
            right: { anchor: "__container__", align: HorizontalAlign.End }
          })

        Image("")
          .backgroundColor("#000000")
          .width(7)
          .height(10)
          .id("arrow")
          .alignRules({
            bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
            right: { anchor: "__container__", align: HorizontalAlign.End }
          })
        Text(`${this.taskNum}`)
          .fontColor($r("app.color.color_1A1D1B"))
          .fontSize(14)
          .margin({ right: 9 })
          .id("txtNum")
          .alignRules({
            bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
            right: { anchor: "arrow", align: HorizontalAlign.Start }
          })
      }.width("100%")
      .height("100%")
    }.width("100%")
    .height("100%")
    .padding(12)

  }
}

class DataSource extends BasicDataSource {
  private data: string[] = ["数组0", "数组1"]

  public getData(index: number): string {
    return this.data[index]
  }

  public totalCount(): number {
    return this.data.length
  }

  public addData(s: string) {
    this.data.push(s)
    this.notifyDataAdd(this.data.length - 1)
  }
}

@Component
struct TaskFoot {
  private dataSource: DataSource = new DataSource()

  build() {
    Column() {
      Row() {
        Text("最新消息")
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
        Blank()
        Image("")
          .width(6)
          .height(10)
          .backgroundColor("#000000")
      }.width("100%")
      .backgroundColor($r("app.color.color_FFFFFF"))
      .padding({ left: 22, top: 12, right: 18, bottom: 12 })

      Column() {
        List({ space: 10 }) {
          LazyForEach(this.dataSource, (item: string) => {
            ListItem() {
              if (item.includes("数组")) {
                ListItem1()
              } else {
                ListItem2()
              }
            }
          }, (item: string) => {
            return item
          })
        }.cachedCount(2)
        .listDirection(Axis.Vertical)
        .width("100%")
      }.width("100%")
      .padding({ left: 10, top: 10, right: 10 })
    }
  }

  aboutToAppear() {
    // 接口请求示例
    let httpRequest = http.createHttp()
    httpRequest.on("headersReceive", (header) => {
      console.log("task, head来了：" + JSON.stringify(header));
      this.dataSource.addData("接口head来了")
      this.dataSource.addData("数组2")
      this.dataSource.addData("数组3")
    })
    httpRequest.request("https://apis.juhe.cn/fapigw/naming/query", {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      extraData: {
        "key": "替换成实际的key", // post示例，如果是GET就把参数拼接到url之后
        "surname": "公孙",
        "sex": "boy",
        "limit": 5
      }
    }, (err, data) => {
      httpRequest.off("headersReceive")
      if (err) {
        console.error("task, " + JSON.stringify(err))
      } else {
        console.log("task, " + JSON.stringify(data.result));
      }
      httpRequest.destroy()
      this.dataSource.addData("接口返回数据来了")
      this.dataSource.addData("数组4")
      this.dataSource.addData("数组5")
    })
  }
}

@Component
struct ListItem1 {
  build() {
    Column() {
      Row() {
        Text("标签1")
          .fontColor("#6B707B")
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .padding({ left: 14, top: 5, right: 14, bottom: 5 })
          .borderColor("#6B707B")
          .borderRadius(10)
          .borderWidth(1)
        Text("标签2")
          .fontColor($r("app.color.color_46C378"))
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .padding({ left: 14, top: 5, right: 14, bottom: 5 })
          .margin({ left: 6 })
          .borderColor($r("app.color.color_46C378"))
          .borderRadius(10)
          .borderWidth(1)
        Blank()
        Text("1分钟前")
          .fontSize(10)
        Image("")
          .width(3)
          .height(14)
          .backgroundColor("#000000")
          .margin({ left: 12 })
      }.width("100%")
      .padding({ left: 15, top: 10, right: 15, bottom: 10 })

      Line()
        .width("100%")
        .height(1)
        .backgroundColor("#000000")
      Row() {
        Text("xxxxxxxxxxxx111111111111xxxxxxxxxxx123456")
          .width("100%")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
      }.width("100%")
      .padding({ left: 12, top: 16, right: 12, bottom: 16 })

      Line()
        .width("100%")
        .height(1)
        .backgroundColor("#000000")
      Row() {
        Column() {
          Text("XXXX")
          Text("YYYY")
            .margin({ top: 12 })
        }.layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Line()
          .width(1)
          .height(33)
          .backgroundColor("#000000")
          .margin({ left: 17, right: 17 })
        Column() {
          Text("ZZZZ")
          Text("ABCD")
            .margin({ top: 12 })
        }.layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }.width("100%")
      .padding(12)
    }.width("100%")
    .backgroundColor($r("app.color.color_FFFFFF"))
    .borderRadius(6)
  }
}

@Component
struct ListItem2 {
  build() {
    Column() {
      Row() {
        Text("标签1")
          .fontColor("#6B707B")
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .padding({ left: 14, top: 5, right: 14, bottom: 5 })
          .borderColor("#6B707B")
          .borderRadius(10)
          .borderWidth(1)
        Text("标签2")
          .fontColor("#6B9FFF")
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .padding({ left: 14, top: 5, right: 14, bottom: 5 })
          .margin({ left: 6 })
          .borderColor("#6B9FFF")
          .borderRadius(10)
          .borderWidth(1)
        Blank()
        Text("2分钟前")
          .fontSize(10)
        Image("")
          .width(3)
          .height(14)
          .backgroundColor("#000000")
          .margin({ left: 12 })
      }.width("100%")
      .padding({ left: 15, top: 10, right: 15, bottom: 10 })

      Line()
        .width("100%")
        .height(1)
        .backgroundColor("#000000")
      Row() {
        Text("xxxxxxxxxxxx111111111111xxxxxxxxxxx123456")
          .width("100%")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
      }.width("100%")
      .padding({ left: 12, top: 16, right: 12, bottom: 16 })
    }.width("100%")
    .backgroundColor($r("app.color.color_FFFFFF"))
    .borderRadius(6)
  }
}

export default TaskComponent