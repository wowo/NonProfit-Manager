# -*- coding: utf-8 -*-
from nonprofitManager.models import *
from django.contrib import admin

class MemberAdmin(admin.ModelAdmin):
    fieldsets = (
       ('Podstawowe', {
           'fields': ('name', 'surname', 'fatherName', 'membershipType')
       }),
       ('Identyfikatory', {
           'fields': ('pesel', 'identityCardNumber')
       }),
       ('Daty', {
           'fields': ('birthDate', 'birthPlace', 'accessionDate', 'dismissDate')
       }),
       ('Adres i zawód', {
           'fields': ('address', 'occupation', 'workplace')
       }),
       ('Kontakt', {
           'fields': ('phone', 'email', 'ggNumber', 'comments')
       }),
    )
    list_display =['id', 'name', 'surname', 'fatherName', 'age', 'birthDate', 'pesel', 'identityCardNumber', 
        'phone', 'email', 'ggNumber', 'address', 'accessionDate', 'yearsOfService', 'dismissDate', 'createdAt',]
    list_display_links = ['id', 'surname']
    list_filter = ['birthDate', 'accessionDate',]

admin.site.register(Member, MemberAdmin)
admin.site.register(Section)
