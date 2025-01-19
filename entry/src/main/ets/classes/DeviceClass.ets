export class newDeviceClass
{
  deviceName:string='';
  devicePic:Resource;

  constructor(deviceName:string,devicePic:Resource){
    this.deviceName=deviceName;
    this.devicePic=devicePic;
  }

}

export class DeviceClass
{
  id:number=0;
  deviceName:string='';
  deviceType:string=''
  scene:string=''

  constructor(id:number,deviceName:string,deviceType:string,scene:string){
    this.id=id;
    this.deviceName=deviceName;
    this.deviceType=deviceType;
    this.scene=scene;
  }
}