import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/entity/entity_details_page.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class CustomerDetailsPage extends ContactBasedDetailsPage<Customer> {
  CustomerDetailsPage(TbContext tbContext, String customerId)
      : super(tbContext,
            entityId: customerId,
            defaultTitle: 'Customer',
            subTitle: 'Customer details');

  @override
  Future<Customer?> fetchEntity(String customerId) {
    return tbClient.getCustomerService().getCustomer(customerId);
  }
}
