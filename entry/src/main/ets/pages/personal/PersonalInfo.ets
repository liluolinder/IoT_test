import { BusinessError } from '@ohos.base';
import { photoAccessHelper } from '@kit.MediaLibraryKit';

@Component
export  struct PersonalInfo {

  @State userName:string='暂未登录';
/*  @State choosePhotoArrary: Array<string> = []; // 全局变量保存图库选择的结果uri
  @State photoCount: number = 0; // 全局变量控制选择图片的显示

  // 接口采用promise异步返回形式，传入可选参数DocumentSelectOptions对象，返回选择文件的uri数组。
  async chooseImageFromType() {
    const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions(); // 创建图片-音频类型文件-预览的图库选项实例
    // 选择媒体文件类型和选择媒体文件的最大数目
    photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE; // 选择媒体文件类型为Image
    photoSelectOptions.maxSelectNumber = 1; // 选择媒体文件的最大数目
    // TODO：知识点：创建图库选择器实例，调用photoViewPicker.select()接口拉起图库界面进行文件选择，文件选择成功后，返回photoSelectResult结果集。
    const photoViewPicker = new photoAccessHelper.PhotoViewPicker();
    photoViewPicker.select(photoSelectOptions)
      .then((photoSelectResult) => {
        // select返回的uri权限是只读权限，需要将uri写入全局变量@State choosePhotoArrary中即可进行读取文件数据操作。
        this.choosePhotoArrary = photoSelectResult.photoUris;
        this.photoCount = this.choosePhotoArrary.length;
      }).catch((err: BusinessError) => {
      return;
    })
  }*/



  build() {

    Row(){

      Image(/*this.photoCount>0?this.choosePhotoArrary[0]:*/$r('app.media.startIcon'))
        .padding('16')
        .height('100%')
        /*.onClick(()=>{
          this.chooseImageFromType()
        })*/

      Text(this.userName)
        .font({size:16,weight:FontWeight.Normal})

    }.backgroundColor(Color.White)
    .height(90)
    .width('90%')
    .borderRadius('5%')

  }
}