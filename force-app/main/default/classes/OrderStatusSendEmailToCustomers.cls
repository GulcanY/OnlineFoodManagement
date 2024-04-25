public with sharing class OrderStatusSendEmailToCustomers {
    @InvocableMethod (label = 'Order Status Email '  
                      category = 'OrderH Object')
    public static void orderStatus(List<Id> orderHid){
        List<String> emlList = new List<String>();
        Id OrderRecordId=orderHid[0];
       
        OrderH__c order=[SELECT id, CustomerH__r.Email__c FROM OrderH__c WHERE id=:OrderRecordId LIMIT 1];
        emlList.add(order.CustomerH__r.Email__c);
        EmailTemplate temp = [SELECT Id, Name, DeveloperName, IsActive FROM EmailTemplate WHERE DeveloperName = 'Order_Staust_1714079930483'];
        
        Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate(temp.Id, null, OrderRecordId);
        mail.SetToaddresses(emlList);
        try {
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
        } catch (Exception ex) {
            System.debug(ex.getMessage());
        }
    }
}