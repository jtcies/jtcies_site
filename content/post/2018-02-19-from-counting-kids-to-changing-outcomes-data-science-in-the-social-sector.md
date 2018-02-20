---
title: 'From Counting Kids to Changing Outcomes: Data Science in the Social Sector'
author: Joe Ciesielski
date: '2018-02-19'
slug: from-counting-kids-to-changing-outcomes-data-science-in-the-social-sector
categories: []
tags: []
comments: no
showcomments: yes
showpagemeta: yes
draft: true
---

The non-profit organizaiton I work at collects tons of data. But the ways in which we use that data is pretty limited. I want to talk about why I think that challenge exits and how we are working to change that fact, putting our data to work improving opportunities for young people[^1]. 

# Challenge

A lot of infrastructure has been built up in the social service sector around data collection. Our data systems are really good at capturing what is happening in programs. Data entry has been made to be relatively seamless in part because funders have recognized that if you make it challening, program staff just won't do it.

The same cannot be said for data extraction from these same systems. In general, these prioprietary data sytems are not designed to give direct access to databases. Instead data is extracted by running specific reports. Each report is generally designed to tell you one and one only one thing. 

The reason for this is because data use is almost exclusively a compliance exercise. You run a report to tell you how you are doing compared to some pre-determined metric. Essentially each metric gets its own report. The chart below shows the reports page for just one of our programs. There are over 50 different reports for just that program. 

<center><img src = "/img/2018-02-19_data_sci_social/eto.png" width=400 height=400 align="middle"></center>

## Counting

This method of data extraction lends itself to being only able to use the data for one thing - counting. A lot of data in the social sector tends to be counting how many particiapnts achieved some outcome, for example. You then divide this by a count of the toal and get a percentage.  

This is not to deny that counting is frequently a useful method to understand what's happening in program through its data. The problem becomes when this is the primary use of the data. Many people have problems with how test scores have negatively impacted schooling in recent years. In my view this is the quintessential example of [counting][^2]: you count how many kids scored above a certain score, count the total who took the test, and then divide. You come out with one number that tells how a classroom, school, or district is performing, but you lose all nuance. 

The main problem with using data in this way is that it does not fit the mental models of what the people most directly invovled with programs - direct service staff such as teachers, case managers, program directors, etc. - have about what they are trying to achieve. They have specific, often unspoken, ideas about how the activities of their program lead to the changes that they want for participants. If the data that is presented to them doesn't interact with the mental models of these staff it doesn't have any chance of impacting how their practice. 

In order to combat this, there are two basic options: shift the mental models or shift the ways in which data is presented. We do a little of both. This post is primarily about how shift the data use to more closely align to staff's mental models. However, I do think it's worth a brief word about shifting mental models. 

In fact, the approach we take is not really to shift mental models but rather than clarify them and make them more explicit. Typically this is done in the social sciences using logic models. And while our approach is similar, logic modes tend to be too simplistic to fully capture the ideas that direct service staff have about their work. 

# Shifting to tidy data






[^1]: This post is modified from a talk I gave at [EARL Boston 2017](https://earlconf.com/). 

[^2]: This isn't to say that the tests themselves are not problematic, just to note that the way that the data is used is also lacking. 

