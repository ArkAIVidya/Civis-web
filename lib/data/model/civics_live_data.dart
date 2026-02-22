import 'package:json_annotation/json_annotation.dart';

part 'civics_live_data.g.dart';

@JsonSerializable()
class CivicsLiveData {
  final int version;
  final Map<String, String> federal;
  final Map<String, StateData> states;

  CivicsLiveData({
    required this.version,
    required this.federal,
    required this.states,
  });

  factory CivicsLiveData.fromJson(Map<String, dynamic> json) =>
      _$CivicsLiveDataFromJson(json);
  Map<String, dynamic> toJson() => _$CivicsLiveDataToJson(this);
}

@JsonSerializable()
class StateData {
  @JsonKey(name: 'governor_name')
  final String governorName;
  @JsonKey(name: 'state_capital')
  final String stateCapital;
  @JsonKey(name: 'senator_1_name')
  final String senator1Name;
  @JsonKey(name: 'senator_2_name')
  final String senator2Name;

  StateData({
    required this.governorName,
    required this.stateCapital,
    required this.senator1Name,
    required this.senator2Name,
  });

  factory StateData.fromJson(Map<String, dynamic> json) =>
      _$StateDataFromJson(json);
  Map<String, dynamic> toJson() => _$StateDataToJson(this);
}
