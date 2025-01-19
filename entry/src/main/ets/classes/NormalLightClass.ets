
export class NormalLightClass{
  id:number=0;
  deviceName:string='';
  scene:string='';
  isOpen:number=0;
  lightBrightness:number=1;


  constructor(id:number,deviceName:string,scene:string,isOpen:number,lightBrightness:number){
    this.id=id;
    this.deviceName=deviceName;
    this.scene=scene;
    this.isOpen=isOpen;
    this.lightBrightness=lightBrightness;
  }
}