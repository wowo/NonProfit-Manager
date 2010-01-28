# -*- coding: utf-8 -*-
from django.db import models
import logging
from datetime import date

class Section(models.Model):
  def __unicode__(self):
    return self.name
  name = models.CharField("Nazwa", max_length=200)
  description = models.TextField("Opis")


class Member(models.Model):
  class Meta:
    ordering = ['surname', 'fatherName', 'birthDate']
    get_latest_by = 'createdAt'
    verbose_name = 'Członek'
    verbose_name_plural = 'Członkowie'
    
  def __unicode__(self):
    return '%s %s' % (self.name, self.surname)

  membershipTypeEnum = (
    ('C', u'Czynny'),
    ('W', u'Wspierający'),
    ('H', u'Honorowy'),
  )

  name = models.CharField("imię", max_length=200)
  surname = models.CharField("nazwisko", max_length=200)
  fatherName = models.CharField("imię ojca", max_length=200, blank=True, null=True)
  birthDate = models.DateField("data urodzenia", blank=True, null=True)
  birthPlace = models.CharField("miejsce urodzenia", max_length=200, blank=True, null=True)
  occupation = models.CharField("zawód", max_length=200, blank=True, null=True)
  workplace = models.CharField("miejsce pracy", max_length=200, blank=True, null=True)
  accessionDate = models.DateField("data wstąpienia", max_length=200, blank=True, null=True)
  dismissDate = models.DateField("data rezygnacji", max_length=200, default=None, null=True, blank=True)
  address = models.TextField("adres", blank=True, null=True)
  identityCardNumber = models.CharField("numer legitymacji", max_length=200, blank=True, null=True)
  pesel = models.CharField("pesel", max_length=15, blank=True, null=True)
  email = models.EmailField("email", blank=True, null=True)
  phone = models.CharField("numer telefonu", max_length=200, blank=True, null=True)
  ggNumber = models.CharField("numer Gadu Gadu", max_length=200, blank=True, null=True)
  membershipType= models.CharField("typ członkowstwa", max_length=1, choices=membershipTypeEnum, default='C')
  comments = models.TextField("uwagi", blank=True, null=True)
#  sections = models.ManyToManyField(Section)
  functions = models.CharField("funkcje", max_length=200, blank=True, null=True)
  createdAt = models.DateTimeField("utworzono", auto_now_add=True)
  updatedAt = models.DateTimeField("zmodyfikowano", auto_now=True)

  def _getAge(self):
    if self.birthDate:
      return date.today().year - self.birthDate.year
    else:
      return 0
  age = property(_getAge)

  def yearsOfService(self):
    return date.today().year - self.accessionDate.year
  yearsOfService.short_description = 'Lata służby'

  def getAllItems(self, request):
    rows = Member.objects.order_by('surname')
    return rows

  def saveFromFlex(self, request, member):
    logging.debug(member)
    member.save()
    return member

  def remove(self, request, member):
    member.delete()


class Award(models.Model):
  class Meta:
    ordering = ['name']
    get_latest_by = 'createdAt'
    verbose_name = 'Odznaczenie'
    verbose_name_plural = 'Odznaczenia'
    
  def __unicode__(self):
    return self.name

  name = models.CharField("nazwa", max_length=255)
  description = models.TextField("opis", blank=True, null=True)
  createdAt = models.DateTimeField("utworzono", auto_now_add=True)
  updatedAt = models.DateTimeField("zmodyfikowano", auto_now=True)

  def getAllItems(self, request):
    rows = Award.objects.order_by('name')
    return rows
