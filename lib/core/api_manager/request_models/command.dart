import 'package:mms/core/extensions/extensions.dart';

import '../../strings/enum_manager.dart';
import '../../util/abstraction.dart';

class FilterRequest {
  FilterRequest({
    required this.filters,
    required this.orderBy,
    required this.pageableQuery,
  });

  final List<Filter> filters;
  final List<OrderBy> orderBy;
  final PageableQuery? pageableQuery;

  factory FilterRequest.fromJson(Map<String, dynamic> json) {
    return FilterRequest(
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
        "filters": filters.map((x) => x.toJson()).toList(),
        "orderBy": orderBy.map((x) => x.toJson()).toList(),
        "pageableQuery": pageableQuery?.toJson(),
      };
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
      operation: _byName(json["operation"] ?? ''),
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

FilterOperation _byName(String s) {
  switch (s) {
    case 'Equals':
      return FilterOperation.equals;
    case 'NotEqual':
      return FilterOperation.notEqual;
    case 'Contains':
      return FilterOperation.contains;
    case 'StartsWith':
      return FilterOperation.startsWith;
    case 'EndsWith':
      return FilterOperation.endsWith;
    case 'LessThan':
      return FilterOperation.lessThan;
    case 'LessThanEqual':
      return FilterOperation.lessThanEqual;
    case 'GreaterThan':
      return FilterOperation.greaterThan;
    case 'GreaterThanEqual':
      return FilterOperation.greaterThanEqual;
    default:
      return FilterOperation.equals;
  }
}
