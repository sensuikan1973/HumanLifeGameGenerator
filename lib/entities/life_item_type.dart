/// アイテム種別
enum LifeItemType {
  /// 職業
  ///
  /// 詳細は key 文字列で表現する.
  job,

  /// 株
  stock,

  /// 配偶者
  spouse,

  /// 家
  house,

  /// 金
  money,

  /// 乗り物
  vehicle,

  /// 子供(女の子)
  childGirl,

  /// 子供(男の子)
  childBoy,

  /// 火災保険
  fireInsurance,

  /// 生命保険
  lifeInsurance,

  /// 地震保険
  earthquakeInsurance,

  /// 自動車保険
  carInsurance,

  /// コーヒー
  ///
  /// 特殊アイテム. 所有している場合、強制的に消費して「1回休み」をくらう.
  coffee,
}
