@Component
export struct NewDeviceCard
{
  @State deviceName:string=''
  @State devicePic:string=''

  build() {
    Column(){
      Image(this.devicePic)
      Text(this.deviceName)
    }
  }
}