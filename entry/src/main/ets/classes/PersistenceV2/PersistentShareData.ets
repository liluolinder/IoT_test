import { DeviceClass } from "../DeviceClass";

@ObservedV2
export class PersistentShareData{
  @Trace isDarkPattern:boolean=false;
  @Trace sceneArray:Array<string>=['全部'];
  @Trace localID:number=-1
  @Trace localSceneID:number=-1
  @Trace curBp:string=''
}