@Entry
@Component
export  struct PersonalInfo {

  @State userName:string='暂未登录';

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

  }
}