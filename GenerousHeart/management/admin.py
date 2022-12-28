from ast import Pass
from django.db.models import Sum
from django.contrib import admin
from . import models
# Register your models here.

@admin.register(models.Payment)
class AdminPayment(admin.ModelAdmin):
    list_display=['pk',
                  'Helper',
                  'sandogh_Helperieh',
                  'tahvilgirandeh_sandogh',
                  'amount',
                  'date'
                  ]
    search_fields=['pk',
                  'Helper__first_name',
                  'Helper__last_name',
                  'sandogh_Helperieh__code',
                  'tahvilgirandeh_sandogh__first_name',
                  'tahvilgirandeh_sandogh__last_name',
                  'amount',
                  ]
    #list_editable=['date']
    list_filter=[
        'id',
        'date',
        'Helper',
        'sandogh_Helperieh',
        'tahvilgirandeh_sandogh',
                ]
    ordering=['date']
    list_per_page=15

@admin.register(models.Helper)
class AdminHelper(admin.ModelAdmin):
    list_display=['pk',
                  'last_name',
                  'first_name',
                  'phone_number',
                  'sum_of_helps',
                  'creating_date'
                  ]
    search_fields=[
        'pk',
                  'last_name',
                  'first_name',
                  'phone_number',
    ]
    #list_editable=['first_name']
    #ordering=['']
    list_per_page=15

    def sum_of_helps(self,Helper):
        return Helper.sum_of_helps2
    def get_queryset(self, request):
        return super().get_queryset(request).annotate(
            sum_of_helps2=Sum('payment__amount')
        )
    
@admin.register(models.Account)
class AdminAccount(admin.ModelAdmin):
    list_display=['name',
                  'account_number',
                  'cart_number',
                  'sum_of_balance'
                  ]
    search_fields=['name']
    def sum_of_balance(self,hesab_moaseseh):
        if hesab_moaseseh.Pay != None and hesab_moaseseh.Recive !=None:
            return hesab_moaseseh.Recive -hesab_moaseseh.Pay
        if hesab_moaseseh.Pay == None:
            hesab_moaseseh.Recive = 0
            return (-1)*hesab_moaseseh.Recive
        return hesab_moaseseh.Pay
    def get_queryset(self, request):
        return super().get_queryset(request).annotate(
            
            Recive=Sum('payment__amount'),
            Pay=Sum('Donation__amount')
            
        )
        
    #list_editable=['']
    #ordering=['']
    list_per_page=15
    


@admin.register(models.PersonInNeed)
class AdminPersonInNeed(admin.ModelAdmin):
    list_display=['first_name',
                  'last_name',
                  'status',
                  'sum_of_helped_recived',
                  'creating_date'
                  ]
    search_fields=[
                'pk',
                'last_name',
                'first_name',
                'phone_number',
                'status',
    ]
    #list_editable=['']
    #ordering=['']
    list_per_page=15
    def sum_of_helped_recived(self,PersonInNeed):
        return PersonInNeed.sum
    def get_queryset(self, request):# set fillter for save or pay

        return super().get_queryset(request).annotate(
            sum=Sum('Donation__amount')
        )
        
    #list_editable=['']
    #ordering=['']
    list_per_page=15
       

@admin.register(models.Receiver)
class AdminReceiver(admin.ModelAdmin):
    list_display=['first_name',
                  'last_name',
                  'phone_number'
                  ]
    search_fields=['first_name',
                  'last_name',
                  'phone_number'
                  ]
    #list_editable=['']
    #ordering=['']
    list_per_page=15

@admin.register(models.CharityBox)
class AdminCharityBox(admin.ModelAdmin):
    list_display=['pk',
                  'Helper'
                  ]
    search_fields=[
        'pk',
        'Helper__first_name',
        'Helper__last_name',
        ]
    #list_editable=['']
    #ordering=['']
    list_per_page=15

@admin.register(models.Donation)
class AdminDonation(admin.ModelAdmin):
    list_display=['PersonInNeed',
                  'hesab_moaseseh',
                  'amount',
                  'date'
                  ]
    
    search_fields=['PersonInNeed__first_name',
                   'PersonInNeed__last_name',
                  'hesab_moaseseh__name',
                  'amount',
                  'date'
                  ]
    #list_editable=['']
    
    ordering=['date']
    list_per_page=15

