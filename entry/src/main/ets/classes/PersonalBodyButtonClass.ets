export class PersonalBodyButtonClass
{
  id:string='';
  buttonInfo:string='';
  buttonToPage:string='';
  isNeedBuildSheet:boolean=false

  constructor(id:string,buttonInfo:string,buttonTopage:string,isNeedBuildSheet:boolean)
  {
    this.id=id;
    this.buttonInfo=buttonInfo;
    this.buttonToPage=buttonTopage;
    this.isNeedBuildSheet=isNeedBuildSheet;
  }
}