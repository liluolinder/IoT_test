import { PersistentShareData } from "../../classes/PersistenceV2/PersistentShareData";
import { PersonalBodyButtonClass } from "../../classes/PersonalBodyButtonClass";
import { PersonalPrivacyButton } from "./PersonalPrivacyButton";
import { AppStorageV2, PersistenceV2 } from "@kit.ArkUI";
import { CacheSHareDataData } from "../../classes/AppStorageV2/CacheShareData";

@ComponentV2
export struct PersonalButtons
{

  pageStack: NavPathStack = new NavPathStack()
  @Local persistentShareData:PersistentShareData=PersistenceV2.connect(PersistentShareData,()=>new PersistentShareData)!;
  @Local cacheSHareDataData:CacheSHareDataData = AppStorageV2.connect(CacheSHareDataData,()=>new CacheSHareDataData())!;


  @Param @Once buttonItem:PersonalBodyButtonClass=new PersonalBodyButtonClass('','','',false);

  @Local isShowBindSheet:boolean=false;

  @Builder
  PersonalPrivacyManageBuildSheet(){
    Column(){
      PersonalPrivacyButton()
    }
  }

  @Builder
  PersonalSettingManageBuildSheet(){
    Column(){
        /*Toggle({type:ToggleType.Switch,isOn:$$this.persistentShareData.isDarkPattern})*/
    }
  }

  changeBuildSheet():CustomBuilder{
    if(this.buttonItem.buttonInfo=='设置')
    {
      return this.PersonalSettingManageBuildSheet()
    }else if(this.buttonItem.buttonInfo=='隐私管理')
    {
      return this.PersonalPrivacyManageBuildSheet()
    }

  }

  build() {

    Button() {

      Row() {

        if(this.buttonItem.id=='0')
        {
          SymbolGlyph($r('sys.symbol.gearshape')).fontSize(26)
        }
        else if(this.buttonItem.id=='1')
        {
          SymbolGlyph($r('sys.symbol.person')).fontSize(26)
        }
        else if(this.buttonItem.id=='2')
        {
          SymbolGlyph($r('sys.symbol.info_circle')).fontSize(26)
        }
        else if(this.buttonItem.id=='3')
        {
          SymbolGlyph($r('sys.symbol.ellipsis_message')).fontSize(26)
        }
        else{
          SymbolGlyph($r('sys.symbol.person_shield')).fontSize(26)
        }

        Text(this.buttonItem.buttonInfo)
          .fontColor(Color.Black)
          .margin({left:5})

        Blank()

        SymbolGlyph($r('sys.symbol.chevron_right')).fontSize(30)

      }.width('95%')

    }
    .width('100%')
    .height('50')
    .backgroundColor(Color.White)
    .margin('5')
    .borderRadius('20')
    .onClick(()=>{
        this.isShowBindSheet=true;
    })
    .bindSheet(this.buttonItem.isNeedBuildSheet && this.isShowBindSheet,this.buttonItem.buttonInfo=='设置'?this.PersonalSettingManageBuildSheet(): this.PersonalPrivacyManageBuildSheet(),
      {
        onDisappear:()=>{this.isShowBindSheet=false;this.cacheSHareDataData.isLookPrivacyStatement=false},
        title:{title:this.buttonItem?.buttonInfo},
        preferType:SheetType.BOTTOM,
        height: this.buttonItem.buttonInfo=='设置'?900:(this.cacheSHareDataData.isLookPrivacyStatement?900:300),
    })
  }

}