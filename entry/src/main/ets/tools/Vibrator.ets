import { vibrator } from '@kit.SensorServiceKit';
export function DefaultHardVibration()             //切换Tab页面时候的震动
{
  try {
    vibrator.startVibration({
      type: 'preset',           //默认
      effectId: 'haptic.effect.hard',   //https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V13/js-apis-vibrator-V13#effectid
      count: 1,          //震动次数
    }, {
      usage: 'touch'          //使用场景，系统决定优先级
    })
  }catch (err)
  {
    return ;
  }
}