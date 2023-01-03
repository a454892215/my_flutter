/// 1.引入json_annotation
import 'package:json_annotation/json_annotation.dart';

/// 2.指定此类的代码生成文件(格式：part '文件名.g.dart';)
part 'json_seri.g.dart';

/// 使用命令flutter packages pub run build_runner build进行一次性构建，
/// 构建过程中flutter会使用Model类的源文件（包含@JsonSerializable标注的）来生成对应的.g.dart文件。
/// 3.添加序列化标注
@JsonSerializable()
class PersonModel {
  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  PersonModel({this.firstName, this.lastName});

  /// 4.添加反序列化方法(格式：factory 类名.fromJson(Map<String, dynamic> json) => _$类名FromJson(json);)
  factory PersonModel.fromJson(Map<String, dynamic> json) => _$PersonModelFromJson(json);

  /// 5.添加序列化方法(格式：Map<String, dynamic> toJson() => _$类名ToJson(this);)
  Map<String, dynamic> toJson() => _$PersonModelToJson(this);
}