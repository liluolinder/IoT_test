import { scanCore, scanBarcode } from '@kit.ScanKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Component
export struct HomeScanCode{
  @State result1:string=''

  build() {

    Column(){

      Text(this.result1)

    }
  }

}