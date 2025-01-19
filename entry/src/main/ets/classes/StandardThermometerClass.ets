
export class StandardThermometerClass{
  id:number=0;
  deviceName:string='';
  scene:string='';

  constructor(id:number,deviceName:string,scene:string){
    this.id=id;
    this.deviceName=deviceName;
    this.scene=scene;
  }

}