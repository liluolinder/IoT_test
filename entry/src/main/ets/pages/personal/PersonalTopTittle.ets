@Entry
@Component
export  struct PersonalTopTittle {
  @State message: string = 'Hello World';

  build() {

    Row(){

      Text('我的')
        .textAlign(TextAlign.Start)
        .font({size:28,weight:FontWeight.Bolder})

    }.width('95%')
    .borderRadius('5%')
    .margin({bottom:10})

  }

}