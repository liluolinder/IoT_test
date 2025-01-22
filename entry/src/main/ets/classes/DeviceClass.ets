export class newDeviceClass
{
  deviceName:string='';
  devicePic:Resource;

  constructor(deviceName:string,devicePic:Resource){
    this.deviceName=deviceName;
    this.devicePic=devicePic;
  }

}
@ObservedV2
export class DeviceClass
{
  id:number=0;
  deviceName:string='';
  deviceType:string='';
  scene:string='';
  isOpen:number=0;
  lightBrightness:number=0;

  constructor(id:number,deviceName:string,deviceType:string,scene:string,isOpen:number,lightBrightness:number){
    this.id=id;
    this.deviceName=deviceName;
    this.deviceType=deviceType;
    this.scene=scene;
    this.isOpen=isOpen;
    this.lightBrightness=lightBrightness;
  }
}