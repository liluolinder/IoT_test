import { scanCore, scanBarcode } from '@kit.ScanKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';

@ComponentV2
export struct HomeScanCode{
  @Param @Once result1:string=''

  build() {

    Column(){

      Text(this.result1)

    }
  }

}