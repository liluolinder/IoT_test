
@ComponentV2
export  struct PersonalTopTittle {

  build() {

    Row(){

      Text('我的')
        .textAlign(TextAlign.Start)
        .font({size:28,weight:FontWeight.Bolder})

    }.width('90%')
    .borderRadius('20')
    .margin({bottom:10})

  }

}