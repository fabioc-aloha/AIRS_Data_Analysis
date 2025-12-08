
---
## Page 1
---

Vol.:(0123456789)
Annals of Operations Research (2022) 308:641–652
https://doi.org/10.1007/s10479-020-03918-9
1 3
S.I.: ARTIFICIAL INTELLIGENCE IN OPERATIONS MANAGEMENT
Adoption and use of AI tools: a research agenda grounded 
in UTAUT​
Viswanath Venkatesh1
Published online: 19 January 2021 
© The Author(s), under exclusive licence to Springer Science+Business Media, LLC part of Springer Nature 2021
Abstract
This paper is motivated by the widespread availability of AI tools, whose adoption and 
consequent benefits are still not well understood. As a first step, some critical issues that 
relate to AI tools in general, humans in the context of AI tools, and AI tools in the context 
of operations management are identified. A discussion of how these issues could hinder 
employee adoption and use of AI tools is presented. Building on this discussion, the uni-
fied theory of acceptance and use of technology is used as a theoretical basis to propose 
individual characteristics, technology characteristics, environmental characteristics and 
interventions as viable research directions that could not only contribute to the adoption 
literature, particularly as it relates to AI tools, but also, if pursued, such research could help 
organizations positively influence the adoption of AI tools.
Keywords  AI tools · UTAUT​ · Employee adoption · Technology use
1  Introduction
Artificial intelligence (AI) saw its genesis in the mid-1950s. Despite its initial promise, it 
stuttered to what seemed like an end for a variety of reasons such as technology limitations, 
including data processing capability, handling different types of data, and approximating 
human thinking. The tremendous growth of technology has been a critical contributing fac-
tor to the resurgence of AI tools that remedy the limitations of the past. The growth of AI 
tools and its promise of benefits for organizations are unprecedented. Organizations are 
scrambling to invest in, deploy and leverage AI tools in various areas of organizational 
functioning to harvest its benefits, create competitive advantage, and enhance performance.
The definition of AI tools and what they entail itself is continuing to evolve, especially 
with the integration with many new and modern technologies, such as Internet of Things, 
and data, such as big data (Wang et al. 2019a, b). There is a growing body of research on 
various aspects of AI tools, especially focused on design of AI tools ranging from require-
ments elicitation (Wang et al. 2019a, b) to technical aspects (Romanova et al. 2019) in a 
variety of settings such as supply chain (Priore et al. 2019), biomedicine (Kocheturov et al. 
 *	 Viswanath Venkatesh 
	
vvenkatesh@vvenkatesh.us
1	
Pamplin College of Business, Virginia Tech, Blacksburg, VA 24061, USA


---
## Page 2
---

642
	
Annals of Operations Research (2022) 308:641–652
1 3
2019), and smart healthcare in clinical settings (Pan et al. 2019). Performance of such AI-
based tools, especially in comparison to previous approaches and algorithms, is of inter-
est (Razzaghi et al. 2019), with a particular focus on avoiding biases that can creep into 
models, especially when learning comes from data that is riddled with bias (Lambrecht and 
Tucker 2019).
Not unlike numerous technologies before AI that came with extraordinary promise, the 
ground reality tends to be far different. A major hurdle to garnering benefits is adoption 
and use of any technology. AI tools are and will continue to be no different. At the organi-
zational level, amongst the problems hindering adoption are several usual suspects—such 
as the need for infrastructure, the need for appropriate training, the lack of a business case, 
and inadequate skills to name but a few. Several articles have been written in the trade 
press that outline these problems.1 Although there may be unique elements that hinder the 
organizational adoption of AI tools, I argue that some of the problems are typical of any 
technology implementation.
Turning to employee adoption of AI tools, which is a necessary step to organizational 
adoption and garnering of benefits, unlike in the case of organizational adoption, there are 
a number of unique aspects of AI tools that could play a critical role, especially in hin-
dering employee adoption. Employee adoption of technology is a mature area of research, 
with many established theories that successfully predict the adoption and use of a broad 
range of technologies (see Venkatesh et al. 2016). The unified theory of acceptance and 
use of technology (UTAUT; Venkatesh et al. 2003) is among the most widely used theories 
that has successfully replicated numerous times and, in fact, used to study a variety of tech-
nologies and even contexts beyond employee adoption. Critically, contextual conditions 
and attributes unique to specific technologies are known to play a role in the ultimate adop-
tion and use of those technologies (for examples, see Brown et al. 2010; Hong et al. 2014). 
Contextual issues that can influence employee adoption of AI are thus the focus of this 
work. AI tools, at least currently, as noted earlier, span a wide spectrum to provide deci-
sion making support and even decision making in a variety of contexts. The particular shift 
with AI tools is not only powered by the availability of enormous amount of data, but also 
by a shift from decision support to actual decision making. With AI tools, the human deci-
sion maker—i.e., employee—could thus be relegated to playing a secondary role or have 
no role to play. On the positive side, AI tools may indeed be able to process a lot of data, 
even in real-time, to arrive at inferences that can be the basis of good decisions, thus free-
ing up employees for more strategic and/or abstract thinking. On the flip side, for instance, 
an AI tool used by Amazon used to screen job applications led to biases against women job 
applicants (see Schuetz and Venkatesh 2020). Undoubtedly, this is but one example of an 
AI tool replacing a human being in making a decision of substantial significance. Taking 
the human intervention away from the decision-making process means organizations rely 
on AI tools to make decisions, the consequences of which may not be felt until later in the 
business process. Thus, a middle ground would seem that AI tools are used by employees 
in much the same way as decision support tools were in the past, albeit with a focus on 
more sophisticated problems and to support more complex decisions. This would give the 
employee the leeway to leverage the AI tools and its power to support decision making, as 
1   Two illustrative sources of organizational challenges are: https​://petuu​m.com/2019/04/02/seven​-chall​
enges​-of-adopt​ing-artif​icial​-intel​ligen​ce-solut​ions/ and https​://neote​ric.eu/blog/12-chall​enges​-of-ai-adopt​
ion/.


---
## Page 3
---

643
Annals of Operations Research (2022) 308:641–652	
1 3
he or she should see fit. It is the adoption of AI tools in such a middle ground that is the 
focus of this paper.
Moving beyond the general topic of AI tools, it is important to consider how AI tool 
adoption will be unique in the case of tools built to support operations management (OM). 
One clear distinguishing feature of OM, compared to other business disciplines except per-
haps information systems (IS), is that it necessarily spans across a large chain of business 
functioning by connecting an organization to upstream activities tied to vendors all the way 
to downstream activities tied to distribution and even retail. By relating to the entire supply 
chain and logistics, OM is a broad discipline and tools that seek to support OM may need 
to factor this. Such OM problems have been long supported by various approaches pow-
ered by mathematical models and algorithms, and they are progressively seeing the use of 
AI, especially machine learning, approaches in the quest for solutions.
Against this backdrop, this paper has the specific objectives:
1.	 Identify general issues related to AI tools and unique issues related to AI tools in the 
context of OM that could potentially hinder employee adoption and use of such tools; 
and
2.	 Using UTAUT as the underlying theoretical basis, present a research agenda to study 
the adoption and use of AI tools in OM, with implications for the broader adoption and 
use of AI tools by employees in organizations.
2   AI tools and operations management: what’s general and what’s 
unique?
As we consider AI tools for OM, it is important to recognize and identify several issues 
that AI tools present that may hinder their adoption by employees. These issues are organ-
ized into three areas: (1) general issues with AI tools; (2) general challenges with employ-
ees; and (3) unique issues with AI tools for OM.
2.1  General issues with AI tools
1.	 Model is blackboxed With AI tools, often, the underlying model itself is blackboxed and 
the user has little or no visibility into the underlying algorithm or process that renders 
the decision. Users are unlikely to always embrace this, especially if there is account-
ability on the part of the user for the consequences.
2.	 Model errors Almost by definition, a model is bound to make mistakes, given that it 
is, after all, a representation of reality. Such mistakes are particularly more likely in 
dynamic environments and/or environments where there is greater uncertainly or lack 
of data, as may sometimes be the case when extra-organization entities are involved, 
which is often the case in supply-chain and logistics matters. With errors come a lack 
of trust in the model decisions or recommendations. With mistakes building up over 
time, there could be a potential negative impact on use over time.
3.	 Model learning takes time Related to, but somewhat distinct from, the issue of model 
errors is the fact, AI models will learn over time that will likely and hopefully result 
in the performance improving over time. Such learning and early mistakes will be 
particularly more pronounced when, as noted in the previous point, the environment is 


---
## Page 4
---

644
	
Annals of Operations Research (2022) 308:641–652
1 3
dynamic in contexts like supply-chain and logistics where more partners, limited data 
and/or data of questionable quality may be involved.
4.	 Model bias Models do tend to have biases, some of which may be emergent and 
unknown initially (see Schuetz and Venkatesh 2020) such as in the case of the Amazon 
job applicant screening tool. The bigger the biases that develop, especially those with 
significant adverse consequences, the greater the resistance that is likely to build.
2.2  General challenges with employees
5.	 Human biases and greater trust in human judgment Employees, each with their unique 
background and experiences in general and experiences in the specific organization, 
business unit and/or job, will have numerous biases. Some of these biases would be the 
result of heuristics that they have developed over time. Although these biases could be 
as severe or worse than what AI tools may have/develop and such biases could lead to 
bigger or more frequent mistakes than what AI tools may make, employees may simply 
have greater trust in their own judgment or judgment of their coworkers.
6.	 Algorithm aversion An interesting and evolving issue seems to be a particular character-
istic that manifests as an aversion to what the core of AI tools are—i.e., algorithms. This 
issue is broader than the earlier set of issues identified earlier related to models in that 
this particular issue has nothing to do with whether the model is right or wrong, rather 
it is simply a matter of a preference for no algorithm—i.e., no AI tools—altogether.
2.3  Unique issues with AI tools for OM
	 7.	
More stakeholders Compared to AI tools built to serve specific business units or jobs 
within specific business units, AI tools and concomitant algorithms/models for OM 
will necessarily need to take more stakeholders data/information into account because 
of the very nature of the supply chain and logistics activities. This will build greater 
uncertainty and may lead to, as articulated earlier, errors and biases. Beyond that, due 
to such challenges, employees using AI tools to support OM activities may be reluctant 
to adopt and use them.
	 8.	
Incomplete and/or missing data Models will often be based on incomplete or missing 
data, and this is likely to be exacerbated with more stakeholders being involved and 
especially more extra-organizational stakeholders involved, which, as noted earlier, is 
likely to be the case in an OM context.
	 9.	
Unknown or incorrect assumptions Going beyond the availability of data is that mod-
els, given that they are a representation of reality, are based on numerous assumptions. 
For models that are narrower in scope, such as the ones that are supporting specific 
jobs or specific jobs within specific business units with little or no interfaces with 
other business units or extra-organization entities, such assumptions may be accurate. 
However, in an OM context, just like missing or incomplete data, assumptions made 
may be unknown/unspecified or incorrect—such assumptions can in turn be a direct 
contributor to some of the issues, such as model errors, articulated earlier.
	10.	
Changing landscape Due to the number of stakeholders involved and the complex and 
long chain involved, the landscape of parameters, not just assumptions, that influence 
activities may be changing in ways that are not readily apparent and thus cannot be 
used to inform the model, especially in a dynamic manner. Much like faulty assump-


---
## Page 5
---

645
Annals of Operations Research (2022) 308:641–652	
1 3
tions or missing data, such a situation is also likely to contribute to problems, such as 
model errors, like the ones articulated earlier.
In sum, there are several issues with AI tools, some general, some specific to employ-
ees, and some unique to AI tools in an OM context that will play a role in potentially hin-
dering employee adoption.
3  Research agenda
Against the backdrop of the issues discussed earlier, in this section, a research agenda using 
UTAUT as the underlying theoretical basis is proposed. Note that UTAUT has been used 
to study the full spectrum of technology adoption from initial adoption to post-adoptive 
use (e.g., Venkatesh et al. 2011). The key ideas of UTAUT from Venkatesh et al. (2003) 
are presented here. UTAUT has four predictors of intention to use and technology use: 
performance expectancy, effort expectancy, social influence, and facilitating conditions. 
These constructs are defined as follows: performance expectancy is defined as the degree 
to which an individual believes that using a system will enhance their job performance; 
effort expectancy is defined as the degree of ease associated with the use of the system; 
social influence refers to an individual’s perception that important others believe that he 
or she should use the new system; and facilitating conditions refers to individual’s belief 
that an organizational and technical infrastructure exists to support use of the system. Up 
to four variables moderate various relationships: gender, age, experience, and voluntari-
ness of use [for a discussion of moderators, see Morris and Venkatesh (2000), Morris et al. 
(2005), Venkatesh and Morris (2000); Venkatesh et al. (2004)]. Figure 1 presents UTAUT 
and the future research directions suggested. Table 1 maps the issues related to AI tools 
with the proposed future research directions including illustrative research questions.
I have, in the past, proposed research agendas for the topic of individual-level adoption 
and use of technology both in general (Venkatesh et al. 2007, 2016a, b, c; Venkatesh and 
Bala 2008; Zhang and Venkatesh 2018) and in specific contexts including those related 
to operations management (e.g., Venkatesh 2006, 2013). These serve as the backdrop to 
propose research that can be conducted to better understand and foster employee adoption 
Fig. 1   UTAUT and proposed future research directions


---
## Page 6
---

646
	
Annals of Operations Research (2022) 308:641–652
1 3
Table 1   Research agenda
AI tool issues
UTAUT-related research directions
Illustrations
1. Model is blackboxed
2. Model errors
3. Model learning takes time
4. Model bias
All these issues related to the model 
create situations of uncertainty 
that users have to embrace and/or 
tolerate
Individual characteristics
Technology characteristics
Environmental characteristics
Interventions
Role of personality in influencing UTAUT predictors. Some individual characteristics could be 
moderators of the impact of model opacity on UTAUT predictors and the impact of UTAUT 
predictors on outcomes.
Design characteristics (such as transparency) can enhance perceptions about UTAUT predictors 
(such as performance expectancy). Similarly, some design characteristics could serve as mod-
erators of the impact of the relationship of the perceptions of the model to UTAUT predictors 
and UTAUT predictors to outcomes.
Some situations lead to higher levels of model opacity and consequent negative impacts on 
UTAUT predictors and/or moderators, as noted above.
Interventions are always crucial to foster adoption and use—and when faced with new models 
of decision making and related impacts on job characteristics, interventions will be especially 
critical. Interventions can be designed such that they vary depending on various other charac-
teristics. For instance, the interventions for the more risk-averse may be different.
5. Human biases and greater trust in 
human judgment
6. Algorithm aversion
These relate to issues employees can 
have that hinder their willingness to 
adopt AI tools, especially the more 
opaque the tools are
Individual characteristics
Technology characteristics
Environmental characteristics
Interventions
The ideas here are similar in spirit to what was is outlined above in that various aspects of indi-
viduals, the design of the tool, and the environment will play a role. In addition, interventions 
can be designed to enhance adoption and use.
7. More stakeholders
8. Incomplete and/or missing data
9. Unknown or incorrect assumptions
10. Changing landscape
Individual characteristics
Technology characteristics
Environmental characteristics
Interventions
Building on the spirit of what has already been noted above, OM contexts create greater levels of 
uncertainty and incomplete information. The impacts of these issues can be especially signifi-
cant in terms of when, where, how, and who will adopt and use AI tools. For instance, the more 
the stakeholders who are involved and in a dynamic environment, with a great of missing data, 
the more likely there could be barriers to adoption, and careful investigation and planning of 
interventions will be critical.
General
Outcomes
Critical employee outcomes, such as job characteristics, job satisfaction, job stress and job per-
formance, may be affected by the use of AI tools. Accumulating benefits at the employee level 
is critical to get higher-level (e.g., business unit, organizational) benefits.


---
## Page 7
---

647
Annals of Operations Research (2022) 308:641–652	
1 3
and use of AI tools, with a particular eye toward how to increase such adoption and use, 
especially in the OM context. As with most research agendas, the suggestions here are not 
meant to be exhaustive but meant to provide illustrations and conceptual ideas that can spur 
further investigations.
As noted in Venkatesh et al. (2016) and associated works (Venkatesh 2014; Venkatesh 
et al. 2014), UTAUT has served as a powerful general theoretical model and its embed-
ded constructs have been predictive in a variety of contexts, including different cultures 
(Venkatesh and Zhang 2010), and among a variety of technologies—agile systems (Hong 
et al. 2011), digital libraries (Hong et al. 2001; Thong et al. 2002), e-government (Chan 
et al. 2010; Venkatesh et al. 2011, 2012, 2016), e-tax filing (Hu et al. 2009), mobile data 
services (Hong et al. 2008; Xu et al. 2017), and personal ICT (Thong et al. 2011). Building 
on the prior general research agendas, there are the following four key research opportuni-
ties here: (1) antecedents/determinants of UTAUT constructs including interventions; (2) 
moderators of UTAUT relationships; (3) new predictors; and (4) consequences.
3.1  Antecedents/determinants and UTAUT​
One of the most fruitful and important avenues leveraging UTAUT as a theoretical basis is 
to examine antecedents/determinants that are tailored to the particular technology. A gen-
eral framework adapted from Thong (1999), Venkatesh et al. (2007, 2016) and Venkatesh 
and Bala (2008) include individual characteristics, such as personality, technology char-
acteristics, such as quality, environmental characteristics (including as perceived by the 
employee), such as culture of innovation, and interventions, such as training. I elaborate on 
these next.
Individual characteristics are critical in most technology adoption and use contexts. In 
this particular case, given the likelihood of errors, uncertainty, and opaqueness, personal-
ity characteristics related to these attributes of the technology may be particularly rele-
vant. Individuals who are likely to be more risk-seeking, tolerant of uncertainty, and with a 
desire to learn are more likely to adopt AI tools. Beyond this, traditional technology-related 
traits, such as computer self-efficacy and computer playfulness (see Venkatesh 2000; Ven-
katesh and Davis 1996), could also play a role. General personality traits could also be 
relevant. These traits can influence the various predictors in UTAUT, especially perfor-
mance expectancy, effort expectancy and facilitating conditions. Together, these individual 
characteristics can play a role in how employees deal with issues with the AI tools and/
or general challenges faced by employees Overall, researchers should investigate potential 
traits that could foster or hinder the adoption of AI tools. Using this knowledge, organiza-
tions can then identify those who may be able to create a positive environment around the 
technology.
Technology characteristics can be examined either as perceptions of employees or 
objective characteristics depending on the nature of the investigation. The particular char-
acteristics of AI tools connected to the various potential challenges, which were described 
earlier, could play a role. For instance, perceptions of model errors by employees or per-
ceptions of the availability or complete information from other entities in the supply chain 
could have an impact on UTAUT predictors, especially performance expectancy. If multi-
ple tools were to be compared, objective characteristics of the different competing options 
on the various parameters, related to the errors, could be examined to see which of them 
has a strong/substantial effect. Further, design characteristics of AI tools, especially as it 
relates to the model, such as transparency, could influence UTAUT predictors.


---
## Page 8
---

648
	
Annals of Operations Research (2022) 308:641–652
1 3
Environmental characteristics including the organizational climate that promotes inno-
vation, learning and other aspects that will allow the tools and associated challenges to 
work themselves out over a period of time will likely lead employees to adopt and use such 
tools. Like with technology characteristics, depending on the nature of the studies, i.e., one 
organization [business unit] being studied or several organizations [business units] being 
studied, these investigations can also be conducted as perceptions of employees or defined 
characteristics of specific organizations [business units]. A number of specific attributes 
pertaining to the environment in which AI tools are used can have an impact on UTAUT 
predictors. These include the range and number of stakeholders, the lack of data or incom-
plete or missing data, uncertainty, biases, and extent to which the environment itself is 
dynamic. All of these environmental characteristics can vary independently or in tandem 
to create a variety of situations that can play a key role in determining UTAUT predictors.
Interventions, ranging from generic training to various types of training to innovative 
approaches using gamification (see Venkatesh 1999), could be used to study the impact on 
adoption and use. Venkatesh and Bala (2008) provide an elaborate framework for study-
ing interventions and their impacts on technology adoption. In particular, when there is 
likely to be significant uncertainly surrounding the workings of the system, appropriate 
management and support practices may be critical to achieving not only the desired project 
outcomes, but also the desired employee outcomes (Morris and Venkatesh 2010; Rai et al. 
2009; Sykes 2015, 2020; Sykes and Venkatesh 2017; Sykes et al. 2009, 2014). Although 
good management and support practices to include significant roles for the users is gener-
ally important, it could be expected that they will even more important given the potential 
problems and uncertainty surrounding supply-chain management systems.
3.2  Moderators
The four categories of constructs, discussed in Sect. 3.1, could potentially play a moderat-
ing role as well. To illustrate, it is possible that individual characteristics can moderate the 
effect of one or more of the UTAUT predictors (e.g., performance expectancy) on intention 
or use. Similarly, it is possible for environmental variables to play a moderating role. For 
instance, it is possible that high tolerance for uncertainty could result in a situation where 
low performance expectancy, say due to high model errors, may not have as detrimental an 
effect. Another example is where a favorable climate of innovation may result in a stronger 
effect of social influence on intention. Beyond this, these relationships could vary across 
cultures (Hoehle et al. 2015; Maruping et al. 2019; Thongpapanl et al. 2018; Venkatesh 
et al. 2010, 2016) and time (Venkatesh et al. 2006). Further, a variety of these effects could 
be non-linear (Brown et al. 2008, 2012, 2014; Venkatesh and Goyal 2010).
3.3  New predictors
Going beyond direct effects on UTAUT predictors discussed in Sect. 3.1 and the moder-
ating effects discussed in Sect. 3.2, these variables can potentially have direct effects on 
intention and use or even downstream outcomes/consequences. It should be noted that 
beyond the sets of constructs, described in Sect.  3.1, that could influence the various 
UTAUT predictors or directly influence outcomes, such as intention, use and/or other out-
comes, there could be other predictors with direct and/or interaction effects on outcomes. 
For instance, it is possible to envision that environmental variables will have an effect on 
intention, use and/or outcomes of using AI tools. The context can often create particular 


---
## Page 9
---

649
Annals of Operations Research (2022) 308:641–652	
1 3
variables that could drive intention and/or use. An important example of adding predictors 
to UTAUT can be readily seen in the evolution of UTAUT to UTAUT 2 (Venkatesh et al. 
2012). UTAUT 2 was created by tailoring UTAUT to the context of consumers using tech-
nologies for personal use and specifically adding three predictors (e.g., habit). Additionally, 
modifications were made to UTAUT in UTAUT 2 by dropping voluntariness of use as a 
moderator that in turn suggests that, the discussion earlier, could include addition and/or 
deletion of main effects (predictors) and/or moderators.
3.4  Outcomes/consequences
The various outcomes/consequences that are typically studied in the technology adoption 
literature, such as intention, behavioral expectation and different conceptualizations of use, 
should be studied (Maruping et al. 2017; Robert and Sykes 2017; Venkatesh et al. 2008). 
In addition, the impacts of AI tools on job characteristics (Bala and Venkatesh 2013; Mor-
ris and Venkatesh 2010) merit attention. Various employee outcomes, ranging from job 
performance and job satisfaction to job stress should be studied (Sykes 2015, 2020; Sykes 
and Venkatesh 2017).
4  Conclusion
This paper presented a research agenda to study the employee adoption and use of AI tools. 
UTAUT, which is one of the most widely used theories to explain individual-level adoption 
and use, is used as a theoretical basis for the proposed agenda. Based on ten issues with 
AI tools (e.g., model bias), including issues specific to AI tools in operations management 
(e.g., incomplete information from extra-organizational stakeholders), individual character-
istics (e.g., tolerance for uncertainty), technology characteristics (e.g., model quality), envi-
ronmental characteristics (e.g., innovation climate), and interventions (e.g., gamified train-
ing) are proposed as possible determinants of UTAUT constructs, moderators of UTAUT 
relationships, and possible additional direct predictors of employee adoption and use.
References
Bala, H., & Venkatesh, V. (2013). Changes in employees’ job characteristics during an enterprise system 
implementation: A latent growth modeling perspective. MIS Quarterly, 37(4), 1113–1140.
Brown, S. A., Dennis, A. R., & Venkatesh, V. (2010). Predicting collaboration technology use: Integrating 
technology adoption and collaboration research. Journal of Management Information Systems, 27(2), 
9–54.
Brown, S. A., Venkatesh, V., & Goyal, S. (2012). Expectation confirmation in technology use. Information 
Systems Research, 23(2), 474–487.
Brown, S. A., Venkatesh, V., & Goyal, S. (2014). Expectation confirmation in information systems research: 
A test of six competing models. MIS Quarterly, 38(3), 729–756.
Brown, S. A., Venkatesh, V., Kuruzovich, J. N., & Massey, A. P. (2008). Expectation confirmation: An 
examination of three competing models. Organizational Behavior and Human Decision Processes, 
105(1), 52–66.
Chan, F. K. Y., Thong, J. Y. L., Venkatesh, V., Brown, S. A., Hu, P. J.-H., & Tam, K. Y. (2010). Modeling 
citizen satisfaction with mandatory adoption of an e-government technology. Journal of the Associa-
tion for Information Systems, 11(10), 519–549.


---
## Page 10
---

650
	
Annals of Operations Research (2022) 308:641–652
1 3
Hoehle, H., Zhang, X., & Venkatesh, V. (2015). An espoused cultural perspective to understand continued 
intention to use mobile applications: A four-country study of mobile social media application usability. 
European Journal of Information Systems, 24(3), 337–359.
Hong, S. J., Thong, J. Y. L., Moon, J. Y., & Tam, K. Y. (2008). Understanding the behavior of mobile data ser-
vices consumers. Information Systems Frontiers, 10(4), 431–445.
Hong, W., Chan, F. K. Y., Thong, J. Y. L., Chasalow, L., & Dhillon, G. (2014). A framework and guidelines 
for context-specific theorizing in information systems research. Information Systems Research, 25(1), 
111–136.
Hong, W., Thong, J. Y. L., Chasalow, L., & Dhillon, G. (2011). User acceptance of agile information systems: A 
model and empirical test. Journal of Management Information Systems, 28(1), 235–272.
Hong, W., Thong, J. Y. L., Wong, W. M., & Tam, K. Y. (2001). Determinants of user acceptance of digital 
libraries: An empirical examination of individual differences and system characteristics. Journal of Man-
agement Information Systems, 18(3), 97–124.
Hu, P. J. H., Brown, S. A., Thong, J. Y. L., Chan, F. K. Y., & Tam, K. Y. (2009). Determinants of service quality 
and continuance intention of online services: The case of eTax. Journal of the American Society for Infor-
mation Science and Technology, 60(2), 292–306.
Kocheturov, A., Pardalos, P. M., & Karakitsiou, A. (2019). Massive datasets and machine learning for computa-
tional biomedicine: Trends and challenges. Annals of Operations Research, 276, 5–34.
Lambrecht, A., & Tucker, C. (2019). Algorithmic bias? An empirical study of apparent gender-based discrimi-
nation in the display of STEM career ads. Management Science, 65(7), 2966–2981.
Maruping, L. M., Bala, H., Venkatesh, V., & Brown, S. A. (2017). Going beyond intention: Integrating behav-
ioral expectation into the unified theory of acceptance and use of technology. Journal of the American 
Society for Information Science and Technology, 68(3), 623–637.
Maruping, L. M., Venkatesh, V., Thong, J. Y. L., & Zhang, X. (2019). A risk mitigation framework for informa-
tion technology projects: A cultural contingency perspective. Journal of Management Information Sys-
tems, 36(1), 120–157.
Morris, M. G., & Venkatesh, V. (2010). Job characteristics and job satisfaction: Understanding the role of enter-
prise resource planning system implementation. MIS Quarterly, 34(1), 143–161.
Morris, M. G., Venkatesh, V., & Ackerman, P. L. (2005). Gender and age differences in employee decisions 
about new technology: An extension to the theory of planned behavior. IEEE Transactions on Engineering 
Management, 52(1), 69–84.
Pan, J., Ding, S., Wu, D., Yang, S., & Yang, J. (2019). Exploring behavioural intentions toward smart healthcare 
services among medical practitioners: A technology transfer perspective. International Journal of Produc-
tion Research, 57(18), 5801–5820.
Priore, P., Ponte, B., Rosillo, R., & de la Fuente, D. (2019). Applying machine learning to the dynamic selection 
of replenishment policies in fast-changing supply chain environments. International Journal of Production 
Research, 57(11), 3663–3677.
Rai, A., Maruping, L. M., & Venkatesh, V. (2009). Offshore information system project success: The role of 
social embeddedness and cultural characteristics. MIS Quarterly, 33(3), 617–641.
Razzaghi, T., Safro, I., Ewing, J., Sadrfaridpour, E., & Scott, J. D. (2019). Predictive models for bariatric sur-
gery risks with imbalanced medical datasets. Annals of Operations Research, 280, 1–18.
Robert, L. P., & Sykes, T. A. (2017). Extending the concept of control beliefs: Integrating the role of advice 
networks. Information Systems Research, 28(1), 84–96.
Romanova, T., Stoyan, Y., Pankratov, A., Litvinchev, I., Avramov, K., Chernobryvko, M., et al. (2019). Opti-
mal layout of ellipses and its application for additive manufacturing. International Journal of Production 
Research. https​://doi.org/10.1080/00207​543.2019.16978​36.
Schuetz, S. W., & Venkatesh, V. (2020). Research perspectives: The rise of human machines: How cognitive 
computing systems challenge assumptions of user-system interaction. Journal of the Association for Infor-
mation Systems, 21(2), 460–482.
Sykes, T. A. (2015). Support structures and their impacts on employee outcomes: A longitudinal field study of 
an enterprise system implementation. MIS Quarterly, 39(2), 473–495.
Sykes, T. A. (2020). Enterprise system implementation and employee job outcomes: Understanding the role of 
formal and informal support structures using the job strain model. MISQuarterly, 44(4), 2055–2086.
Sykes, T. A., & Venkatesh, V. (2017). Explaining post-implementation employee system use and job perfor-
mance: Impacts of the content and source of social network ties. MIS Quarterly, 41(3), 917–936.
Sykes, T. A., Venkatesh, V., & Johnson, J. L. (2014). Enterprise system implementation and employee job per-
formance: Understanding the role of advice networks. MIS Quarterly, 38(1), 51–72.
Sykes, T. A., Venkatesh, V., & Gosain, S. (2009). Model of acceptance with peer support: A social network 
perspective to understand employees’ System Use. MIS Quarterly, 33(2), 371–393.
Thong, J. Y. L. (1999). An integrated model of information systems adoption in small businesses. Journal of 
Management Information Systems, 15(4), 187–214.


---
## Page 11
---

651
Annals of Operations Research (2022) 308:641–652	
1 3
Thong, J. Y. L., Hong, W., & Tam, K. Y. (2002). Understanding user acceptance of digital libraries: What are 
the roles of interface characteristics, organizational context, and individual differences? International 
Journal of Human-Computer Studies, 57(3), 215–242.
Thong, J. Y. L., Venkatesh, V., Xu, X., Hong, S.-J., & Tam, K. Y. (2011). Consumer acceptance of personal 
information and communication technology services. IEEE Transactions on Engineering Management, 
58(4), 613–625.
Thongpapanl, N., Ashraf, A. R., Lapa, L., & Venkatesh, V. (2018). Unveiling the differential effects of con-
sumers’ regulatory fit on trust, perceived value, and m-commerce usage among developed and developing 
countries. Journal of International Marketing, 26(3), 22–44.
Venkatesh, V. (1999). Creation of favorable user perceptions: Exploring the role of intrinsic motivation. MIS 
Quarterly, 23(2), 239–260.
Venkatesh, V. (2000). Determinants of perceived ease of use: Integrating control, intrinsic motivation, and emo-
tion into the technology acceptance model. Information Systems Research, 11(4), 342–365.
Venkatesh, V. (2006). Where to go from here? Thoughts on future directions for research on individual-level 
technology adoption with a focus on decision making. Decision Sciences, 37(4), 497–518.
Venkatesh, V. (2013). IT, supply chain, and services: Looking ahead. Journal of Operations Management, 
31(6), 281–284.
Venkatesh, V. (2014). IT, supply chain, and services: Looking ahead. In C. Cooper, D. Straub, & R. Welke 
(Eds.), The Wiley encyclopedia of management (pp. 295–303). Chichester: Wiley.
Venkatesh, V., & Bala, H. (2008). Technology Acceptance model 3 and a research Agenda on interventions. 
Decision Sciences, 39(2), 273–315.
Venkatesh, V., & Morris, M. G. (2000). Why don’t men ever stop to ask for directions? Gender, social influence, 
and their role in technology acceptance and usage behavior. MIS Quarterly, 24(1), 115–139.
Venkatesh, V., Bala, H., & Sykes, T. A. (2010). Impacts of information and communication technology imple-
mentations on employees’ jobs in service organizations in India: A multimethod longitudinal field study. 
Production and Operations Management, 19(5), 591–613.
Venkatesh, V., Bala, H., & Sambamurthy, V. (2016). Implementation of an information and communication 
technology in a developing country: A multimethod longitudinal study in a Bank in India. Information 
Systems Research, 27(3), 558–579.
Venkatesh, V., Brown, S. A., Maruping, L. M., & Bala, H. (2008). Predicting different conceptualizations of 
system use: The competing roles of behavioral intention, facilitating conditions, and behavioral expecta-
tion. MIS Quarterly, 32(3), 483–502.
Venkatesh, V., Chan, F. K. Y., & Thong, J. Y. L. (2012). Designing E-government Services: Key service attrib-
utes and citizens’ preference structures. Journal of Operations Management, 30(1–2), 116–133.
Venkatesh, V., & Davis, F. D. (1996). A model of the antecedents of perceived ease of use: Development and 
test. Decision Sciences, 27(3), 451–481.
Venkatesh, V., & Davis, F. D. (2000). A theoretical extension of the technology acceptance model: Four longi-
tudinal field studies. Management Science, 46(2), 186–204.
Venkatesh, V., Davis, F. D., & Morris, M. G. (2007). Dead or alive? The development, trajectory and future of 
technology adoption research. Journal of the Association for Information Systems, 8(4), 267–286.
Venkatesh, V., & Goyal, S. (2010). Expectation disconfirmation and technology adoption: Polynomial modeling 
and response surface analysis. MIS Quarterly, 34(2), 281–303.
Venkatesh, V., Maruping, L. M., & Brown, S. A. (2006). Role of time in self-prediction of behavior. Organiza-
tional Behavior and Human Decision Processes, 100(2), 160–176.
Venkatesh, V., Morris, M. G., & Davis, F. D. (2014). Individual-level technology adoption research: An assess-
ment of the strengths, weaknesses, threats and opportunities for further research contributions. In H. Topi 
(Ed.), CRC Computing Handbook Set (3rd ed., pp. 38-1-38–25). Boca Raton, FL: CRC Press.
Venkatesh, V., Morris, M. G., Davis, F. D., & Davis, G. B. (2003). User acceptance of information technology: 
Toward a unified view. MIS Quarterly, 27(3), 425–478.
Venkatesh, V., Morris, M. G., Sykes, T. A., & Ackerman, P. L. (2004). Individual reactions to new technologies 
in the workplace: The role of gender as a psychological construct. Journal of Applied Social Psychology, 
34(3), 445–467.
Venkatesh, V., Thong, J. Y. L., Chan, F. K. Y., & Hu, P. J. (2016). Managing citizens’ uncertainty in e-Gov-
ernment services: The mediating and moderating roles of transparency and trust. Information Systems 
Research, 27(1), 87–111.
Venkatesh, V., Thong, J. Y. L., Chan, F. K. Y., Hu, P. J.-H., & Brown, S. A. (2011). Extending the two-stage 
information systems continuance model: Incorporating UTAUT predictors and the role of context. Infor-
mation Systems Journal, 21(6), 527–555.
Venkatesh, V., Thong, J. Y. L., & Xu, X. (2012). Consumer acceptance and use of information technology: 
Extending the unified theory of acceptance and use of technology. MIS Quarterly, 36(1), 157–178.


---
## Page 12
---

652
	
Annals of Operations Research (2022) 308:641–652
1 3
Venkatesh, V., Thong, J. Y. L., & Xu, X. (2016). Unified theory of acceptance and use of technology: A syn-
thesis and the road ahead. Journal of the Association for Information Systems, 17(5), 328–376.
Venkatesh, V., & Zhang, X. (2010). Unified theory of acceptance and use of technology: U.S. Vs. China. 
Journal of Global Information Technology Management, 13(1), 5–27.
Wang, Y., Lin, Y., Zhong, R. Y., & Xu, X. (2019a). IoT-enabled cloud-based additive manufacturing plat-
form to support rapid product development. International Journal of Production Research, 57(12), 
3975–3991.
Wang, Z., Chen, C. H., Zheng, P., Li, X., & Khoo, L. P. (2019b). A graph-based context-aware requirement 
elicitation approach in smart product-service systems. International Journal of Production Research, 
57(20), 1–17.
Xu, X., Thong, J. Y. L., & Tam, K. Y. (2017). Winning back technology disadopters: Testing a technology 
re-adoption model in the context of mobile internet services. Journal of Management Information Sys-
tems, 34(1), 102–140.
Zhang, X., & Venkatesh, V. (2018). From design principles to impacts: A theoretical framework and 
research agenda. AIS Transactions on Human-Computer Interaction, 10(2), 105–128.
Publisher’s Note  Springer Nature remains neutral with regard to jurisdictional claims in published maps and 
institutional affiliations.


---
## Page 13
---

Reproduced with permission of copyright owner.
Further reproduction prohibited without permission.
