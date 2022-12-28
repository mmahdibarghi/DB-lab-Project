
from django.db import models
from django_jalali.db import models as jmodels

class Helper(models.Model):
    ACTIVE='ACTIVE'
    DEACTIVE='DEACTIVE'
    
    choices_status=[
        (ACTIVE,'Active'),
        (DEACTIVE,'deactive')          
                    ]
    HelperID = models.AutoField(primary_key=True)
    FirstName=models.CharField(max_length=55)
    LastName=models.CharField(max_length=55)
    NationalCode=models.CharField(max_length=10,null=False,unique=True,blank=False)
    PhoneNumber=models.CharField(max_length=13,null=False,blank=False)
    Address=models.TextField(null=False,blank=False)
    PostCode=models.CharField(max_length=10,null=False,blank=False)
    Status=models.CharField(max_length=10,choices=choices_status,default=ACTIVE,null=False,blank=False)
    TotalHelped=models.BigIntegerField()
    CreatingDate=jmodels.jDateField(auto_now_add=True,null=False)
    #auto new add for first create
    def __str__(self) -> str:
        return self.LastName +" "+ self.FirstName
    class Meta:
        ordering=['LastName','FirstName']
class CharityBox(models.Model):
    BIG_PLASTIC='BIG-PLASTIC'
    SMALL_PLASTIC='SMALL-PLASTIC'
    BIG_STEEL='BIG-STEEL'
    SMALL_STEEL='SMALL-STEEL'
    type_choices=[
        (BIG_PLASTIC,'Big-Plastic'),
        (SMALL_PLASTIC,'Small-Plastic'),
        (BIG_STEEL,'Big-Steel'),
        (SMALL_STEEL,'Small-Steel')    
    ]
    ACTIVE='ACTIVE'
    DEACTIVE='DEACTIVE'
    ARCHIVE='Archive'
    choices_status=[
        (ACTIVE,'Active'),
        (DEACTIVE,'Deactive'),
        (ARCHIVE,'Archive')            
                    ]
    CharityBoxID=models.AutoField(primary_key=True)
    Code=models.IntegerField(null=False,blank=False,unique=True)
    Type=models.CharField(max_length=50,choices=type_choices)
    Status=models.CharField(max_length=10,choices=choices_status,default=ACTIVE,null=False,blank=False)
    StartDate=jmodels.jDateField(auto_now_add=True)
    HelperID=models.ForeignKey(Helper,on_delete=models.PROTECT,null=False,blank=False,default=None)
    def __str__(self) -> str:
        return str(self.pk)
    class Meta:
        ordering=['pk']

class Assign(models.Model):
    AssignID = models.AutoField(primary_key=True)
    AssignDate=jmodels.jDateField(auto_now_add=True)
    CharityBoxID=models.ForeignKey(CharityBox,on_delete=models.PROTECT)
    CharityBoxReceiverID=models.ForeignKey('CharityBoxReceiver',on_delete=models.PROTECT)
    
    
class CharityBoxReceiver(models.Model):
    CharityBoxReceiverID = models.AutoField(primary_key=True)
    FirstName = models.CharField(max_length=255)
    LastName = models.CharField(max_length=255)
    NationalCode = models.CharField(max_length=10,null=False,unique=True,blank=False)
    PhoneNumber = models.CharField(max_length=13,null=False,blank=False)
    CreatingDate = jmodels.jDateField(null=False,auto_now_add=True)
    
    def __str__(self) -> str:
        return self.LastName +" "+ self.FirstName
    class Meta:
        ordering=['LastName','FirstName']

class PayToCharity(models.Model):
    CART='CART'
    CASH='CASH'
    BOX='BOX'
    typechoice=[
        (CART,'Cart'),
        (CASH,'Cash'),
        (BOX,'Box'),
    ]
    PaymentID=models.AutoField(primary_key=True)
    HelperID=models.ForeignKey(Helper,on_delete=models.PROTECT,null=False,blank=False)
    CharityBoxID=models.ForeignKey(CharityBox,on_delete=models.PROTECT,null=False,blank=False)
    CharityBoxReceiverID=models.ForeignKey(CharityBoxReceiver,on_delete=models.PROTECT,null=False,blank=False)
    AccountID=models.ForeignKey('Account',on_delete=models.PROTECT,null=False,blank=False)
    Amount=models.BigIntegerField()
    PaymentDate=jmodels.jDateField(auto_now=True,null=False)
    '''date for last modify or create date'''
    PaymentType=models.CharField(max_length=10,choices=typechoice,default=BOX,null=True,blank=True)
    authority=models.CharField(max_length=255,null=True,blank=True)
    ref_code=models.CharField(max_length=255,null=True,blank=True)
    HasPaid=models.BooleanField(default=True,null=False,blank=False)
    CardNumber=models.CharField(max_length=16,null=True,blank=True)
    Bank=models.CharField(max_length=30,null=True,blank=True)
    Description=models.TextField(max_length=200, null=True,blank=True)
    
    def __str__(self) -> str:
        return str(self.pk)
    class Meta:
        ordering=['PaymentDate']
        
        
class Account(models.Model):
    AccountID = models.AutoField(primary_key=True)
    Name = models.CharField(max_length=30,null=False,blank=False)
    AccountNum = models.CharField(max_length=12)
    CardNum = models.CharField(max_length=16)
    TotalBalance = models.BigIntegerField(default=0)
    def __str__(self) -> str:
        return self.Name
    class Meta:
        ordering=['Name']

class Donation(models.Model):
    DonationID=models.AutoField(primary_key=True)
    AccountID=models.ForeignKey(Account,on_delete=models.PROTECT,null=False,blank=False)
    ClientID=models.ForeignKey('PersonInNeed',on_delete=models.PROTECT,null=False,blank=False)
    Amount=models.BigIntegerField(null=False,blank=False)
    Date=jmodels.jDateField(auto_now=True,null=False)
    '''date for create date'''

class PersonInNeed(models.Model):
    ACTIVE='ACTIVE'
    DEACTIVE='DEACTIVE'
    choices_status=[
        (ACTIVE,'Active'),
        (DEACTIVE,'deactive')          
                    ]
    PersonInNeedID=models.AutoField(primary_key=True)
    FirstName=models.CharField(max_length = 30,null=False,blank=False)  
    LastName=models.CharField(max_length = 30, null=False,blank=False)
    NationalCode=models.CharField(max_length=10,null=False,blank=False,unique=True)
    PhoneNumber=models.CharField(max_length=13,null=False,blank=False)
    Address=models.TextField(max_length=60,null=False,blank=False)
    PostCode=models.CharField(max_length=10,null=True,blank=True)
    Status=models.CharField(max_length=10,choices=choices_status,default=ACTIVE)
    TotalMoneyReceived=models.BigIntegerField(default=0,null=False,blank=False)
    CreateDate=jmodels.jDateField(auto_now=True,null=False)
    def __str__(self) -> str:
        return self.LastName +" "+ self.FirstName
    class Meta:
        ordering=['LastName','FirstName']
    