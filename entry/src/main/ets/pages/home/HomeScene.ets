import { hilog } from "@kit.PerformanceAnalysisKit";
import { PersistentShareData } from "../../classes/PersistenceV2/PersistentShareData";
import { deleteSceneFromRDB, GetSceneInfoFromRdb } from "../../tools/DoingToRdb";
import { AppStorageV2, PersistenceV2 } from "@kit.ArkUI";
import { HomeCard } from "./HomeCard";
import { DefaultHardVibration } from "../../tools/Vibrator";
import { CacheSHareDataData } from "../../classes/AppStorageV2/CacheShareData";

@ComponentV2
export struct HomeScene{
  @Local cacheSHareDataData:CacheSHareDataData = AppStorageV2.connect(CacheSHareDataData,()=>new CacheSHareDataData())!;
  @Local persistentShareData:PersistentShareData=PersistenceV2.connect(PersistentShareData,()=>new PersistentShareData)!;
  @Local focusIndex: number = 0;
  @Local index: number = 0;
  private controller: TabsController = new TabsController();
  private listScroller: Scroller = new Scroller();

  @Builder
  MoreSceneMenu()
  {
    Menu(){

      ForEach(this.persistentShareData.sceneArray,(scene:string,index:number)=>{

        MenuItem({content:scene})
          .selected(index === this.focusIndex ? true : false)
          .onChange((selected: boolean) => {
            if(selected)
            {
              this.controller.changeIndex(index);
              this.listScroller.scrollToIndex(index, true, ScrollAlign.CENTER);

            }
          })
          .backgroundColor(index === this.focusIndex ? '#0A59F7' : Color.White)

      })

    }

  }

  @Builder
  SceneListDeleteOrChangeName(scene:string,index:number){

    Menu(){

      MenuItem({content:'删除场景'})
        .onClick(()=>
        {

          if(scene=='全部')
          {

              AlertDialog.show({
                title: '你在干圣魔',
                message: '全部分类怎么能删啊喂',
                isModal: true,
                autoCancel: true,
              })

          }else{

            if(index==this.focusIndex)
            {
              this.controller.changeIndex(0);
              this.listScroller.scrollToIndex(0, true, ScrollAlign.CENTER);
            }
            deleteSceneFromRDB(scene)
            setTimeout(()=>{this.cacheSHareDataData.isRefresh=true;}
              ,50)

          }

        })


      MenuItem({content:'重命名'})

    }

  }

  build() {

    Scroll(){

      Column() {

        Row() {

          Stack(){

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
                    .height('100%')
                    .margin({ left: 8, right: 8 })
                    .onClick(() => {
                      this.controller.changeIndex(index);
                      this.listScroller.scrollToIndex(index, true, ScrollAlign.CENTER);
                    })

                  }.bindContextMenu(this.SceneListDeleteOrChangeName(item,index),ResponseType.LongPress,{placement:Placement.Bottom,onAppear:()=>{DefaultHardVibration()}})

                })

            }
            .width('100%')
            .height('70%')
            .listDirection(Axis.Horizontal)
            .scrollBar(BarState.Off)

            Column()
            {
              Button(){
                SymbolGlyph($r('sys.symbol.dot_grid_2x2')).fontSize('35')
              }.backgroundColor('#F1F3F5')
              .bindMenu(this.MoreSceneMenu())

            }.position({right:0})

          }

        }
        .alignItems(VerticalAlign.Center)
        .height(52)



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