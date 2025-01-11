
@Component
export struct NormalLightCard{

  @State lightName:string=''
  @State lightPic:string=''

  build() {

    Column(){

      Image(this.lightPic)
      Blank()
      Text(this.lightName)
    }.backgroundColor(Color.White)
    .width(150)
    .height(150)
    .borderRadius('5%')

  }

}