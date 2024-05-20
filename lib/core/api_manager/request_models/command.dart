import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../strings/enum_manager.dart';

class FilterRequest {
  FilterRequest({
    this.filters,
    this.orderBy,
    this.pageableQuery,
    this.partyId,
  });

  List<Filter>? filters = [];
  List<OrderBy>? orderBy = [];
  PageableQuery? pageableQuery;
  String? partyId;

  factory FilterRequest.fromJson(Map<String, dynamic> json) {
    return FilterRequest(
      partyId: json['partyId'],
      filters: json["filters"] == null
          ? []
          : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
      orderBy: json["orderBy"] == null
          ? []
          : List<OrderBy>.from(
              json["orderBy"]!.map((x) => OrderBy.fromJson(x))),
      pageableQuery: json["pageableQuery"] == null
          ? null
          : PageableQuery.fromJson(json["pageableQuery"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "filters": filters?.map((x) => x.toJson()).toList(),
        "orderBy": orderBy?.map((x) => x.toJson()).toList(),
        "pageableQuery": pageableQuery?.toJson(),
        "partyId": partyId,
      };

  String get getKey {
    var jsonString = jsonEncode(this);
    var bytes = utf8.encode(jsonString);
    var digest = sha1.convert(bytes);

    return '$digest';
  }
}

class Filter {
  Filter({
    required this.name,
    required this.val,
    required this.operation,
  });

  final String name;
  final String val;
  final FilterOperation operation;

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      name: json["name"] ?? "",
      val: json["val"] ?? "",
      operation: FilterOperation.byName(json["operation"] ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "val": val,
        "operation": operation.realName,
      };
}

class OrderBy {
  OrderBy({
    required this.attribute,
    required this.direction,
  });

  final String attribute;
  final String direction;

  factory OrderBy.fromJson(Map<String, dynamic> json) {
    return OrderBy(
      attribute: json["attribute"] ?? "",
      direction: json["direction"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "attribute": attribute,
        "direction": direction,
      };
}

class PageableQuery {
  PageableQuery({
    required this.pageNumer,
    required this.pageSize,
  });

  final num pageNumer;
  final num pageSize;

  factory PageableQuery.fromJson(Map<String, dynamic> json) {
    return PageableQuery(
      pageNumer: json["pageNumer"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "pageNumer": pageNumer,
        "pageSize": pageSize,
      };
}
