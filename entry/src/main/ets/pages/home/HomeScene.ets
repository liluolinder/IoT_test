import { hilog } from "@kit.PerformanceAnalysisKit";
import { PersistentShareData } from "../../classes/PersistenceV2/PersistentShareData";
import { GetSceneInfoFromRdb, sceneArray } from "../../tools/DoingToRdb";
import { PersistenceV2 } from "@kit.ArkUI";
import { HomeCard } from "./HomeCard";

@ComponentV2
export struct HomeScene{

  @Local persistentShareData:PersistentShareData=PersistenceV2.connect(PersistentShareData,()=>new PersistentShareData)!;
  @Local sceneArray:Array<string>=sceneArray
  @Local focusIndex: number = 0;
  @Local index: number = 0;
  private controller: TabsController = new TabsController();
  private listScroller: Scroller = new Scroller();

  build() {

    Scroll(){

      Column() {

        Row() {

          List({ scroller: this.listScroller }) {

            ForEach(this.persistentShareData.sceneArray,
              (item: string, index: number) => {

                ListItem(){

                  Row() {
                    Text(item)
                      .fontSize(14)
                      .fontColor(index === this.focusIndex ? Color.White : Color.Black)
                  }
                  .justifyContent(FlexAlign.Center)
                  .width(95)
                  .backgroundColor(index === this.focusIndex ? '#0A59F7' : '#0D000000')
                  .borderRadius(20)
                  .height(35)
                  .margin({ left: 8, right: 8 })
                  .onClick(() => {
                    this.controller.changeIndex(index);
                    this.listScroller.scrollToIndex(index, true, ScrollAlign.CENTER);
                  })

                }

              })

          }
          .width('100%')
          .height('100%')
          .listDirection(Axis.Horizontal)
          .scrollBar(BarState.Off)
        }
        .alignItems(VerticalAlign.Center)
        .height(52)
        .margin({ top: 8 })


        Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
          ForEach(this.persistentShareData.sceneArray,
            (item: string) => {
              TabContent() {

               HomeCard({localScene:item})

              }

            }, (item: string, index: number) => JSON.stringify(item) + index)
        }
        .width('100%')
        .barHeight('0')
        .onAnimationStart((index: number, targetIndex: number) => {
          this.focusIndex = targetIndex;
          this.listScroller.scrollToIndex(targetIndex, true, ScrollAlign.CENTER);
        })
      }
      .height('100%')

    }

  }

}