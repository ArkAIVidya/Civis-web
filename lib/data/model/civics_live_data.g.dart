// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'civics_live_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CivicsLiveData _$CivicsLiveDataFromJson(Map<String, dynamic> json) =>
    CivicsLiveData(
      version: (json['version'] as num).toInt(),
      federal: Map<String, String>.from(json['federal'] as Map),
      states: (json['states'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, StateData.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$CivicsLiveDataToJson(CivicsLiveData instance) =>
    <String, dynamic>{
      'version': instance.version,
      'federal': instance.federal,
      'states': instance.states,
    };

StateData _$StateDataFromJson(Map<String, dynamic> json) => StateData(
  governorName: json['governor_name'] as String,
  stateCapital: json['state_capital'] as String,
  senator1Name: json['senator_1_name'] as String,
  senator2Name: json['senator_2_name'] as String,
);

Map<String, dynamic> _$StateDataToJson(StateData instance) => <String, dynamic>{
  'governor_name': instance.governorName,
  'state_capital': instance.stateCapital,
  'senator_1_name': instance.senator1Name,
  'senator_2_name': instance.senator2Name,
};
