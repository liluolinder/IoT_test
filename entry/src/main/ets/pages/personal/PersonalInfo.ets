import { BusinessError } from '@ohos.base';
import { photoAccessHelper } from '@kit.MediaLibraryKit';

@Component
export  struct PersonalInfo {

  @State isShow:boolean=false;
  @State userName:string='暂未登录';

  @Builder
  bindSheetLoginInBuilder()
  {
    Column()
    {
      Text('没做完')
    }
  }

  build() {

    Row(){

      Image($r('app.media.startIcon'))
        .padding('16')
        .height('100%')

      Text(this.userName)
        .font({size:16,weight:FontWeight.Normal})

    }.backgroundColor(Color.White)
    .height(90)
    .width('90%')
    .borderRadius('5%')
    .onClick(()=>this.isShow=true)
    .bindSheet($$this.isShow,             //$$引用表示，isShow变量值与组件bindSheetLoginInBuilder状态一致
      this.bindSheetLoginInBuilder(),
      {
        height:300,
        title: { title: "快捷登录", subtitle: "Click to log in" },
      })

  }
}