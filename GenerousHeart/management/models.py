
from django.db import models
from django_jalali.db import models as jmodels

class Helper(models.Model):
    ACTIVE='ACTIVE'
    INACTIVE='INACTIVE'
    UNKNOWN='NUKKNOW'
    choices_status=[
        (ACTIVE,'Active'),
        (INACTIVE,'Inactive'),
        (UNKNOWN,'Unknown')            
                    ]
    first_name=models.CharField(max_length=255)
    last_name=models.CharField(max_length=255)
    national_code=models.CharField(max_length=10,null=True,unique=True,blank=True)
    phone_number=models.CharField(max_length=12,null=True,blank=True)
    address=models.TextField(null=True,blank=True)
    post_code=models.CharField(max_length=10,null=True,blank=True)
    status=models.CharField(max_length=8,choices=choices_status,default=UNKNOWN)
    
    #creating_date=models.TimeField(auto_now_add=True)
    creating_date=jmodels.jDateField(auto_now_add=True)
    #auto new add for first create
    def __str__(self) -> str:
        return self.last_name +" "+ self.first_name
    class Meta:
        ordering=['last_name','first_name']
class CharityBox(models.Model):
    PLASTICB='PLASTICB'
    PLASTICS='PLASTICS'
    FELEZIB='FELEZIB'
    FELEZIS='FELEZIS'
    type_choices=[
        (PLASTICB,'PlasticBig'),
        (PLASTICS,'PlasticBig'),
        (FELEZIB,'FeleziBig'),
        (FELEZIS,'FeleziSmall'),
        
    ]
    ACTIVE='ACTIVE'
    INACTIVE='INACTIVE'
    UNKNOWN='NUKKNOW'
    choices_status=[
        (ACTIVE,'Active'),
        (INACTIVE,'Inactive'),
        (UNKNOWN,'Unknown')            
                    ]
    code=models.CharField(max_length=255,unique=True)
    typee=models.CharField(max_length=8,choices=type_choices)
    status=models.CharField(max_length=8,choices=choices_status,default=UNKNOWN)
    strting_date=jmodels.jDateField(auto_now_add=True)
    Helper=models.ForeignKey(Helper,on_delete=models.PROTECT,null=True,blank=True)
    def __str__(self) -> str:
        return str(self.pk)
    class Meta:
        ordering=['pk']

class Assign(models.Model):
    date=jmodels.jDateField(auto_now_add=True)
    sandogh_Helperieh=models.ForeignKey(CharityBox,on_delete=models.PROTECT)
    tavilgirandeh=models.ForeignKey('Receiver',on_delete=models.PROTECT)
    
    
class Receiver(models.Model):
    first_name=models.CharField(max_length=255)
    last_name=models.CharField(max_length=255)
    national_code=models.CharField(max_length=10,null=True,unique=True,blank=True)
    # national code can be null?????? yes
    phone_number=models.CharField(max_length=12)
    create_date=jmodels.jDateField(null=False,auto_now_add=True)
    
    def __str__(self) -> str:
        return self.last_name +" "+ self.first_name
    class Meta:
        ordering=['last_name','first_name']

class Payment(models.Model):
    CART='CART'
    CASH='CASH'
    SANDOGH='SANDOGH'
    typechoice=[
        (CART,'Cart'),
        (CASH,'Cash'),
        (SANDOGH,'Sandogh'),
    ]
    Helper=models.ForeignKey(Helper,on_delete=models.PROTECT,null=True,default=None,blank=True)
    sandogh_Helperieh=models.ForeignKey(CharityBox,on_delete=models.PROTECT,null=True,default=None,blank=True)
    tahvilgirandeh_sandogh=models.ForeignKey(Receiver,on_delete=models.PROTECT,null=True,default=None,blank=True)
    hesab_moaseseh=models.ForeignKey('Account',on_delete=models.PROTECT)
    #admin_id
    amount=models.BigIntegerField()
    date=jmodels.jDateField(auto_now=True)
    '''date for last modify or create date'''
    typee=models.CharField(max_length=7,choices=typechoice,default=CASH,null=True,blank=True)
    authority=models.CharField(max_length=200,null=True,blank=True)
    ref_code=models.CharField(max_length=12,null=True,blank=True)
    has_paid=models.CharField(max_length=12,null=True,blank=True)
    #max_length of ref and has ??????
    card_number=models.CharField(max_length=16,null=True,blank=True)

    #cart number or account number????
    Helper_bank=models.CharField(max_length=255,null=True,blank=True)
    description=models.TextField(null=True,blank=True)
    
    def __str__(self) -> str:
        return str(self.pk)
    class Meta:
        ordering=['date']
        
        
class Account(models.Model):
    name=models.CharField(max_length=255)
    account_number=models.CharField(max_length=10)
    
    cart_number=models.CharField(max_length=16)
    
    def __str__(self) -> str:
        return self.name
    class Meta:
        ordering=['name']

class Donation(models.Model):
    hesab_moaseseh=models.ForeignKey(Account,on_delete=models.PROTECT)
    PersonInNeed=models.ForeignKey('PersonInNeed',on_delete=models.PROTECT)
    amount=models.BigIntegerField()
    date=jmodels.jDateField(auto_now=True)
    '''date for create date'''

class PersonInNeed(models.Model):
    ACTIVE='ACTIVE'
    INACTIVE='INACTIVE'
    UNKNOWN='NUKKNOW'
    choices_status=[
        (ACTIVE,'Active'),
        (INACTIVE,'Inactive'),
        (UNKNOWN,'Unknown')            
                    ]
    first_name=models.CharField(max_length=255)
    last_name=models.CharField(max_length=255)
    national_code=models.CharField(max_length=10,null=True,unique=True,blank=True)
    phone_number=models.CharField(max_length=12,null=True,blank=True)
    address=models.TextField(null=True,blank=True)
    post_code=models.CharField(max_length=10,null=True,blank=True)
    status=models.CharField(max_length=8,choices=choices_status,default=UNKNOWN)
    creating_date=jmodels.jDateField()
    def __str__(self) -> str:
        return self.last_name +" "+ self.first_name
    class Meta:
        ordering=['last_name','first_name']
    