

@ComponentV2
export struct HomeSceneTab{

  @Local sceneArray:Array<string>=['全部','我的家']

  build() {

    Tabs()
    {
      ForEach(this.sceneArray,(id:number)=>{

        TabContent(){
          Text(id.toString())
        }

      })
    }

  }

}