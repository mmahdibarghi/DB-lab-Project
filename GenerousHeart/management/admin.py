from ast import Pass
from django.db.models import Sum
from django.contrib import admin
from . import models
# Register your models here.

@admin.register(models.PayToCharity)
class AdminPayment(admin.ModelAdmin):
    list_display=['pk',
                  'HelperID',
                  'CharityBoxID',
                  'CharityBoxReceiverID',
                  'Amount',
                  'PaymentDate'
                  ]
    search_fields=['pk',
                  'Helper__FirstName',
                  'Helper__LastName',
                  'CharityBox__Code',
                  'CharityBoxReceiver__FirstName',
                  'CharityBoxReceiver__LastName',
                  'Amount',
                  ]
    
    list_filter=[
        'PaymentID',
        'PaymentDate',
        'HelperID',
        'CharityBoxID',
        'CharityBoxReceiverID',
                ]
    ordering=['PaymentDate']
    list_per_page=15

@admin.register(models.Helper)
class AdminHelper(admin.ModelAdmin):
    list_display=['pk',
                  'LastName',
                  'FirstName',
                  'PhoneNumber',
                  'TotalHelped',
                  'CreatingDate'
                  ]
    search_fields=[
        'pk',
                  'LastName',
                  'FirstName',
                  'PhoneNumber',
    ]

    list_per_page=15


@admin.register(models.Account)
class AdminAccount(admin.ModelAdmin):
    list_display=['Name',
                  'AccountNum',
                  'CardNum',
                  'TotalBalance'
                  ]
    search_fields=['Name']
 

    list_per_page=15
    


@admin.register(models.PersonInNeed)
class AdminPersonInNeed(admin.ModelAdmin):
    list_display=['FirstName',
                  'LastName',
                  'Status',
                  'TotalMoneyReceived',
                  'CreateDate'
                  ]
    search_fields=[
                'pk',
                'LastName',
                'FirstName',
                'PhoneNumber',
                'Status',
    ]

    list_per_page=15
    

@admin.register(models.CharityBoxReceiver)
class AdminReceiver(admin.ModelAdmin):
    list_display=['FirstName',
                  'LastName',
                  'PhoneNumber'
                  ]
    search_fields=['FirstName',
                  'LastName',
                  'PhoneNumber'
                  ]

    list_per_page=15

@admin.register(models.CharityBox)
class AdminCharityBox(admin.ModelAdmin):
    list_display=['pk',
                  'HelperID'
                  ]
    search_fields=[
        'pk',
        'Helper__FirstName',
        'Helper__LastName',
        ]

    list_per_page=15

@admin.register(models.Donation)
class AdminDonation(admin.ModelAdmin):
    list_display=['ClientID',
                  'AccountID',
                  'Amount',
                  'Date'
                  ]
    
    search_fields=['PersonInNeed__FirstName',
                   'PersonInNeed__LastName',
                  'Account__Name',
                  'Amount',
                  'Date'
                  ]

    
    ordering=['Date']
    list_per_page=15

