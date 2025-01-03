@Entry
@Component
export  struct PersonalInfo {

  build() {

    Row(){

      Image($r('app.media.startIcon'))

        .padding('16')
        .height('100%')

    }.backgroundColor(Color.White)
    .height(90)
    .width('95%')
    .borderRadius('5%')

  }
}