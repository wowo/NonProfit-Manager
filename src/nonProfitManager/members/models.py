# -*- coding: utf-8 -*-
from django.db import models

class Section(models.Model):
  def __unicode__(self):
    return self.name
  name = models.CharField("Nazwa", max_length=200)
  description = models.TextField("Opis")

class Member(models.Model):
  def __unicode__(self):
    return '%s %s' % (self.name, self.surname)
  membershipTypeEnum = (
    ('C', u'Czynny'),
    ('W', u'Wspierający'),
    ('H', u'Honorowy'),
  )
  name = models.CharField("Imię", max_length=200)
  surname = models.CharField("Nazwisko", max_length=200)
  fatherName = models.CharField("Imię ojca", max_length=200, blank=True, null=True)
  birthDate = models.DateField("Data urodzenia")
  birthPlace = models.CharField("Miejsce urodzenia", max_length=200, blank=True, null=True)
  occupation = models.CharField("Zawód", max_length=200, blank=True, null=True)
  workplace = models.CharField("Miejsce pracy", max_length=200, blank=True, null=True)
  accessionDate = models.DateField("Data wstąpienia", max_length=200)
  dismissDate = models.DateField("Data rezygnacji", max_length=200, default=None, null=True, blank=True)
  functions = models.CharField("Funkcje", max_length=200, blank=True, null=True)
  address = models.TextField("Adres", blank=True, null=True)
  identityCardNumber = models.CharField("Numer legitymacji", max_length=200, unique=True, blank=True, null=True)
  pesel = models.CharField("Pesel", max_length=15, unique=True)
  email = models.EmailField("Email", blank=True, null=True)
  phone = models.CharField("Numer telefonu", max_length=200, blank=True, null=True)
  ggNumber = models.CharField("Numer Gadu Gadu", max_length=200, blank=True, null=True)
  membershipType= models.CharField("Typ członkowstwa", max_length=1, choices=membershipTypeEnum, default='C')
  comments = models.TextField("Uwagi", blank=True, null=True)
  sections = models.ManyToManyField(Section)
