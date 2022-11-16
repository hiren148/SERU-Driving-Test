import 'dart:convert';

import 'package:driving_test/config/images.dart';
import 'package:driving_test/core/network.dart';
import 'package:driving_test/data/source/network/models/chapter.dart';
import 'package:driving_test/data/source/network/models/question.dart';
import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/theory_part.dart';

class NetworkDataSource {
  final NetworkManager networkManager;

  NetworkDataSource(this.networkManager);

  static const String chaptersURL =
      "https://gist.githubusercontent.com/hiren148/986612d5fceaf1f447c57e9f1cc00754/raw/042e409a8905959ecb7470fdac42178f941e5875/chapters.json";

  static const String reviewURL =
      "https://gist.githubusercontent.com/hiren148/386acfb5043cbec514db73ad11fce746/raw/708dbea1429351580a2cd918cc34ef0a59e0c3d4/review.json";

  Future<List<NetworkQuestionModel>> getQuestionData(Chapter chapter) async {
    final response =
        await networkManager.request(RequestMethod.get, chapter.url);
    final Map<String, dynamic> questionsMap =
        json.decode(json.encode(response.data));
    return (questionsMap['questions'] as List)
        .map((item) => NetworkQuestionModel.fromJson(item))
        .toList();
  }

  Future<List<NetworkChapterModel>> getChapterList() async {
    final response =
        await networkManager.request(RequestMethod.get, chaptersURL);
    final Map<String, dynamic> chapterMap =
        json.decode(json.encode(response.data));
    return (chapterMap['chapters'] as List)
        .map((item) => NetworkChapterModel.fromJson(item))
        .toList();
  }

  Future<List<String>> getReviewList() async {
    final response = await networkManager.request(RequestMethod.get, reviewURL);
    final Map<String, dynamic> reviewMap =
        json.decode(json.encode(response.data));
    return (reviewMap['reviews'] as List).map((e) => e as String).toList();
  }

  Future<List<TheoryPart>> getTheoryData(Chapter chapter) async {
    final response = <TheoryPart>[];
    switch (chapter.id) {
      case 2:
        _buildTheoryForChapter2(response);
        break;
      case 3:
        _buildTheoryForChapter3(response);
        break;
      case 4:
        _buildTheoryForChapter4(response);
        break;
      case 5:
        _buildTheoryForChapter5(response);
        break;
      case 6:
        _buildTheoryForChapter6(response);
        break;
      case 7:
        _buildTheoryForChapter7(response);
        break;
      case 8:
        _buildTheoryForChapter8(response);
        break;
      case 9:
        _buildTheoryForChapter9(response);
        break;
      case 10:
        _buildTheoryForChapter10(response);
        break;
      case 1:
      default:
        _buildTheoryForChapter1(response);
    }
    return response;
  }

  void _buildTheoryForChapter1(List<TheoryPart> response) {
    response.add(TheoryPart(TheoryPartType.title,
        textData: 'Welcome to the SERU Assessment Preparation Course'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: 'So what exactly is SERU?'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Safety, Equality and Regulatory Understanding requirement that applies to all existing licence holder and applicants.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'It\'s a new requirement that came into force on 1 October 2021.'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            'This course will help you reach the level of knowledge required to pass the SERU Assessment at a TfL test centre.'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            'You will study each section by reading the learning materials and completing multiple section mock tests - you can repeat these as many times as you like.'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            'All incorrect answers in the practice sections come with feedback'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'The course covers all sections from the TfL driver\'s handbook'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            'It offers the most effective way to study and at the same time familiarise yourself with the format of the official test.'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: 'Learn in 3 simple steps!'));
    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Step 1 - Read the learning materials'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Step 2 - Practice with feedback - as many times as you like!'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Step 3 - Check your knowledge - Section Mock Tests with real pass mark!'));
    response.add(TheoryPart(TheoryPartType.title,
        textData:
            'SERU assessment All Section Mock Test with same number of questions and pass mark'));
    response.add(TheoryPart(TheoryPartType.image,
        imageData: AppImages.imgTransportLondon));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Once you complete all sections and feel comfortable with your level of knowledge you can proceed to the Final All Section Mock Test.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'It simulates the real SERU assessment by having the exact same number of questions and pass mark.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'It contains random questions from all sections and is split into 3 parts just like the real assessment.'));
    response.add(TheoryPart(
      TheoryPartType.subtitle,
      textData: 'Section 1 - London PHV Driver Licensing',
    ));
    response.add(TheoryPart(
      TheoryPartType.content,
      textData:
          'To work as a London PHV driver, you will need to be licensed by TfL – only then can you carry out bookings for a London private hire operator that is also licensed by TfL.',
    ));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'When you get your licence to work as a London PHV driver, there are a number of rules and policies that you need to know about. This section sets out some of these rules and policies, and explains what you need to do to get a licence.'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '1. Licensing requirements'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '1. You must be aged 21 or older when you apply for your licence. There is no upper age limit.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '2. You must have a full DVLA, Northern Ireland, European Union or European Economic Area state driving licence that is at least three years old.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData: '3. You must have the right to live and work in the UK.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '4. You must be a \'fit and proper\' person to hold a licence. You will need to have an \'enhanced\' criminal records check done by the Disclosure and Barring Service (DBS).'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '5. You must be physically fit. This will mean that you will need to have a medical examination with a doctor who has access to all of your medical records. The medical requirements are the DVLA Group 2 medical standards.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '6. You will need to take a separate test to check your ability to select and plan a route, read a map and identify locations. The test is held in a centre approved by TfL and conducted under exam conditions by a TfL examiner. This test is known as a Topographical Skills Assessment.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '7. You will need to prove that you have at least a B1 level of ability in the English language. B1 is a level of English in the Common European Framework of Reference for Languages (CEFR). To prove your English language speaking and listening skills you will need to take a test. The test is held in a TfL building and conducted under exam conditions. Your English language reading and writing skills will be derived from the Safety, Equality and Regulatory Understanding Assessment.'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '2. Private hire driver\'s licence'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If your application is approved, TfL will send you a London PHV driver’s licence. Your licence may have some conditions attached to it. For example, if you have a medical condition, you may be required to have extra medical checks. Any conditions added to your licence will be explained in the letter sent to you with your licence. It is very important that you keep that letter and comply with any conditions that come with your licence. If you do not, then your licence may be revoked.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'As soon as you are licensed it is important that you keep in contact with us and respond to any letters, emails or other forms of communication.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Your London PHV driver’s licence normally lasts for three years. If it is for a shorter period, the letter that comes with the licence will explain why.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You should keep your licence at home in a safe place and give a copy of it to any licensed private hire operator(s) you are working with.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'The PHV operator(s) you work with must keep copies of your PHV driver’s licence and your DVLA/NI/EU/EEA driving licence.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If a police officer or TfL Authorised Officer asks to see your licence, you must let them see it there and then or within a maximum of seven days.The letter that comes with your licence contains important information about your responsibilities as a London PHV driver, including any conditions you must meet. It is important that you read this letter carefully and make sure you understand it.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If there are conditions on your licence which require you to provide TfL with information – for example if you need to provide further medical information – then TfL may write to you to remind you that the information is needed.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'There are further general conditions that all licence holders need to know. These are given below'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '3. Your PHV driver\'s badge'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Your PHV driver’s badge displays your name, photograph, licence number and the date your licence period ends. Remember, your operator must give passengers your name, photograph and vehicle details. This means that passengers can check this information against your badge.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'When you get your licence you will also receive a PHV driver’s badge (also known as photographic ID). You must wear this badge at all times when you are working as a PHV driver.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You must wear your badge whenever you are working as a PHV driver, including when you are waiting to receive a booking or travelling to pick up a passenger. When you wear it, you must make sure that it can clearly be seen by other people. This applies to all PHV drivers unless we have given you special permission not to. This is called an exemption. If we give you an exemption, we will send you an exemption notice. You must carry that notice with you at all times when working as a PHV driver.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If a passenger asks for your licence number, you should let them see your badge so that they can write the number down. The badge includes text in Braille which means a visually impaired person can know that you are licensed.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Remember the badge is for you to use only! You must not allow any other person to use it to carry out bookings.'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '4. Lost PHV driver\'s badge and licence'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you lose your PHV driver’s badge or licence, or somebody steals it, report it  immediately to TfL. If your badge has been stolen you should also report it to the police and get a crime reference number from them. Without your badge you cannot continue working as a PHV driver.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'TfL will replace your lost or stolen badge or licence. However, if you then find your original badge or licence, you must return it to TfL. Your badge and licence are the property of TfL at all times, including when they have passed their expiry date. You must return them when they pass the expiry date or when you are no longer licensed.'));
    response.add(
        TheoryPart(TheoryPartType.subtitle, textData: '5. Medical conditions'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'o get your licence to be a PHV driver you must be medically fit. The standards you must meet are the DVLA Group 2 medical standards. In most cases, this will mean that you will need to have a medical examination with someone (i.e. a doctor) who has access to your full medical records. '));
    response.add(TheoryPart(TheoryPartType.content,
        textData: 'You may be exempt from supplying a medical form if you:'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Have a full or provisional (issued after January 1997) DVLA Group 2 licence or '));
    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Have a current London taxi driver’s licence or'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Have a valid, current pilot’s licence issued by the Joint Aviation Authorities '));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'TfL will remind you when a medical examination is due and send you the form you need. You are responsible for making sure that a doctor completes the form with all the required information about your health, and for returning the form to TfL. If you have an existing medical condition, extra medical examinations may be needed. If you do not send TfL all the necessary information, you might not get your licence.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'From the age of  45 PHV drivers must have a medical examination  each time they apply to renew  their licence.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'From the age of  65 PHV drivers must have a medical assessment  every year.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You should tell TfL immediately if, between medical examinations, you develop a new medical condition that may affect your ability to drive.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Some examples of medical conditions you should let TfL know about include: '));
    response.add(TheoryPart(TheoryPartType.content, textData: '1. Diabetes'));
    response.add(TheoryPart(TheoryPartType.content, textData: '2. Epilepsy '));
    response.add(TheoryPart(TheoryPartType.content,
        textData: '3. Poor eyesight or other eye conditions affecting sight'));
    response.add(
        TheoryPart(TheoryPartType.content, textData: '4. Heart conditions'));
    response.add(TheoryPart(TheoryPartType.content,
        textData: '5. High blood pressure '));
    response.add(TheoryPart(TheoryPartType.content,
        textData: '6. Neurological conditions (including strokes) '));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '7. Prescription medication that may affect your ability to drive '));
    response.add(
        TheoryPart(TheoryPartType.content, textData: '8. Psychiatric illness'));
    response.add(TheoryPart(TheoryPartType.content,
        textData: '9. Any condition which the DVLA requires you to report '));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you are not sure whether to tell TfL, you should contact TfL for advice. The DVLA frequently updates its medical standards so TfL recommends that you check with the DVLA if you develop any new medical condition.'));
    response.add(
        TheoryPart(TheoryPartType.subtitle, textData: '6. Change of address'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'It important that TfL has your correct home address and email address so that you can be contacted with any information about your licence. If you change your home address you should tell TfL within 21 days. You should also tell us about any change to your email address or telephone number. This is important so TfL can keep you informed of any changes to the regulations to do with how PHVs and PHV drivers are licensed, as well as news and events that could affect your job.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You are also required by law to tell the DVLA if you change your address. You will then get a new driving licence with your new address on it. Details of how to do this are on the back of your DVLA licence. The address on your PHV driver’s licence should be the same as the address on your DVLA licence. '));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Remember, if you change your home address you should tell TfL (within 21 days) and the DVLA.'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '7. Other changes in personal circumstances'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'As a licensed London PHV driver, you must tell TfL  immediately if your personal circumstances change.'));
    response
        .add(TheoryPart(TheoryPartType.content, textData: 'This includes: '));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you have broken the law and have been disqualified from driving. Please note that you will also have to return your London PHV driver’s licence and badge to TfL'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you are the subject of a mental health order or sexual offences order. '));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you are on either the Adults or Children’s Barred Lists  '));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you have a private hire or taxi driver’s licence with another licensing authority and that authority has suspended or revoked your licence, or refused any new application you have made '));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: 'Convictions, cautions and arrests'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You must tell TfL immediately if you are arrested, charged with, convicted or cautioned for any crime. This includes any fixed penalty notices or road traffic offences that result in penalty points on your driving licence.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You are responsible for telling TfL about any offences you have committed. Do not rely on the police informing TfL.  If you fail to tell TfL about a conviction, you could have your licence revoked.  '));
    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Other fixed penalties, parking tickets and PCNs'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You do not need to tell TfL about any other penalty charge notices (PCNs) or parking tickets that do not result in penalty points on your driving licence. However, if TfL becomes aware that you are getting frequent PCNs and/or parking tickets, TfL may take licensing action against you. This is because TfL expects all licensed drivers to behave responsibly. '));
    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Right to live and work in the United Kingdom'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If there are restrictions on a driver’s right to live and work in the UK, TfL will add an appropriate condition on the licence. If you are in this situation, you should make sure you comply with these conditions and make sure you have a continuing right to work.  '));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'In particular, if you are in the UK on a student visa you will only be allowed to work for a limited number of hours each week and you will not be allowed to be self-employed. '));
    response.add(TheoryPart(TheoryPartType.content, textData: 'Complaints'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If TfL receives a complaint about you or becomes aware of any behaviour that is not satisfactory, TfL may write to you with the details and ask for your comments. It is important that you respond to TfL’s request. TfL can only make licensing decisions based on the information received.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Suspending or revoking a PHV driver’s licence'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If for any reason your licence is revoked you must return your licence to TfL  within seven days. If you do not, or your licence has been suspended or revoked with immediate effect, TfL may send an Authorised Officer to take it from you.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Revoking a driver’s private hire vehicle licence'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If your PHV driver’s licence is suspended or revoked, and you are the owner of a licensed private hire vehicle, TfL may make the decision to revoke the vehicle licence as well. TfL will consider doing this if there is any risk to public safety. For example, if there is evidence that the vehicle could be used as a PHV by somebody without a PHV driver licence, or if a driver has been charged with, or convicted of, a serious violent or sexual offence.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Disclosure and Barring Service (DBS)'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'As part of the application process you (the applicant) must have an enhanced criminal records check from the Disclosure and Barring Service (DBS). The DBS is a public body that does checks on people’s backgrounds. The checks will show any convictions, cautions, reprimands and final warnings you have had. The checks will also show if the local police have any information that is relevant to you working as a PHV driver and if you are on a list of people who are prevented from working with vulnerable groups. TfL uses a separate company to arrange DBS checks for applicants - you must use this company to get your DBS certificate. Further details are on the TfL website.'));
  }

  void _buildTheoryForChapter2(List<TheoryPart> response) {
    response.add(TheoryPart(TheoryPartType.title,
        textData: 'Section 2 - Licensing Requirements for PHVs'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'This section gives you information on some of the licensing requirements and rules for private hire vehicles (PHVs). Even if you do not own a licensed vehicle, you should know about these requirements.'));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '1. Licences and licence discs'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Once a PHV has been licensed, the registered keeper is given a vehicle licence and licence discs will be  fixed to the front and rear windscreens of the vehicle. The registered keeper also receives a leaflet which briefly describes the conditions of the licence.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'The licence discs must not be damaged or changed in any way. You should not remove the discs, even if you are using the vehicle for private purposes. The licence discs contain security features which mean that the discs will be permanently damaged if you try to remove them.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If the licence discs fixed to a PHV are damaged, lost, or stolen the vehicle owner should contact TfL immediately so that replacement discs can be issued. '));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Please remember, you cannot use a vehicle for private hire purposes if the licence discs are missing,have been badly damaged or their appearance has been spoilt in any way. '));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'In some exceptional circumstances the vehicle might be given an exemption which means that the licence discs do not have to be displayed. In these cases you will receive an exemption notice which you (the driver) must carry at all times when the vehicle is being used as a PHV. PHV licences last for  one year and the vehicle must have another licensing inspection before a new licence can be issued.'));
    response.add(TheoryPart(TheoryPartType.subtitle, textData: '2. Insurance'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Every PHV must have hire or reward insurance.  We encourage you to carry details of the vehicle\'s valid hire or reward insurance policy  whenever  you are working, as well as evidence that you are insured to drive the vehicle under that policy (for example, if the vehicle is insured by your operator). '));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You can carry the insurance details or display them within the vehicle.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You must make details of the insurance available to the police when you are asked for them. You must also provide insurance details to a passenger or member of the public if the vehicle you are driving is involved in a collision.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'The  insurance policy must be valid when the vehicle is licensed,  and at all times when the vehicle is  being used as a PHV.  '));
    response.add(
        TheoryPart(TheoryPartType.subtitle, textData: '3. Collision damage'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Vehicles must be kept in good condition. If you own your PHV, you must tell TfL within  72 hours of any collision that affects the safety, performance, appearance or comfort  of the vehicle. The vehicle may need to be re-examined before it can continue to be used as a PHV. '));
    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '4. Information about vehicles'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'There may be circumstances where TfL has important information about the vehicle you are driving – for example, the manufacturer may have told TfL about a fault with the vehicle that means it needs to be returned to the manufacturer for repair. If you are the registered keeper of the vehicle TfL or the manufacturer may write to you to explain what you need to do to get your vehicle fixed. You should always follow the instructions in the letter. A letter from TfL may also explain that the vehicle cannot be used for private hire purposes until it has been fixed.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'It is important that you read any letters you receive from TfL or the manufacturer carefully.'));
  }

  void _buildTheoryForChapter3(List<TheoryPart> response) {
    response.add(TheoryPart(TheoryPartType.title,
        textData: 'Section 3 - Carrying out Private Hire Journeys'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Private hire services are an important part of London’s transport network, providing a wide range of services for residents and visitors. This section covers the basic requirements for drivers when carrying out private hire bookings.'));

    response.add(TheoryPart(TheoryPartType.subtitle, textData: '1. Bookings'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'As a London PHV driver, you can only carry out bookings that you have received from a licensed London PHV operator. \nYou must carry out these bookings in a London licensed PHV that has PHV licence discs on display (unless exempt).You should never accept a booking from an unlicensed operator – if you are in any doubt you should ask the operator for their operator licence number and check their details using the online licence checker tool  \nIt is important to remember that a PHV is not a taxi (black cab). This means that: \nYou are not allowed to pick people up on the street or at stations or airports unless they have booked you through a licensed operator. This includes the street outside your operator. \nYou must not allow any passenger to enter your vehicle before you have received the booking from your operator \nYou must not give any sign or say anything to a member of the public that suggests that you are available for hire, without a booking. This is against the law. \nYou must not encourage any member of the public to approach you or your PHV if they don’t have a valid booking.  \nIf someone does come up to you, you are allowed to hand out a business card with the number of your operator on it or you can provide other contact details such as a website.'));

    response.add(
        TheoryPart(TheoryPartType.subtitle, textData: '2. Booking details'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Before the start of each journey, your operator is required to record certain information about the booking. Although you are not personally responsible for collecting or recording these details, you should know about this requirement and let your operator know about any changes. \nThe information your operator must record includes: \nThe date the booking is made and, if different, the date of the journey \nThe name of the person the booking is for \nThe agreed time and place for picking up passengers, or, if more than one location, the agreed time and place for picking up the first passenger \nThe main destination \nThe agreed fare or estimated fare \nThe name or other identification of the driver carrying out the booking and \nThe registration number or other identification of the vehicle that will carry out the booking'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '3. Operating centres in late night venues'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If your operator has a licence to operate from a late night venue,(e.g. a pub or nightclub) the operator can only take bookings inside the venue at the booking location specified on their licence.\nYou can only accept a fare if the passenger has booked the journey through a licensed London operator. You must not approach people on the pavement or outside a late night venue to offer them private hire services. If you do this, you may be committing an offence and could be prosecuted. If a customer approaches you, then you should tell them to contact a licensed private hire operator to make a booking. \nYou, as the driver, are responsible for parking your vehicle, the noise it makes and for your own behaviour. Please think about the environment around the operating centre and how noise, traffic and/or customer movement may affect the people living in the neighbourhood. \nDo not behave in an anti-social manner, do not leave litter in the street or road, do not go to the toilet in a public place, and do not leave your engine running. Have respect for the area you are working in. \nRemember, if TfL or the police get complaints about driver behaviour, they will investigate and, depending on the sort of complaint they receive, it could result in licensing action or prosecution.'));

    response.add(TheoryPart(TheoryPartType.subtitle, textData: '4. Airports'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Airports are private property and can make their own rules (byelaws) about taxis and PHVs Heathrow Airport has its own set of byelaws which you can find here . You should know about these in case you get a booking to or from the airport. \nYou cannot enter Heathrow Airport to pick up passengers unless you have a booking from your operator or you are parking in an official car park or the PHV Authorised Vehicle Area to wait for a booking. When picking up passengers you must always use an official car park. \nYou should not wait in local car parks or residential streets. Remember that the taxi ranks at Heathrow Airport and London City Airport are for licensed taxis (black cabs) only. You must not stop, wait, pick up or drop off passengers at the airport taxi ranks.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '5. Journeys outside Greater London'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'As a London licensed PHV driver, in a London licensed PHV, you may carry out a private hire booking (accepted by a licensed London PHV operator) where the pick-up point and/or the destination for the journey is outside Greater London as long as the booking has been accepted by a licensed London PHV operator. \nIf you have any doubts about whether the journey is legal or not, you should ask your operator.'));

    response.add(TheoryPart(TheoryPartType.subtitle, textData: '6. Fares'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'TfL has no power to set or control the fares charged by PHV operators. However, it is important that all customers understand the fare they are going to be charged. \nIf your passenger: \ndecides to change the destination of their journey \nasks you to pick up extra passengers or has extra luggage \nyou should tell your operator as soon as it is safe for you to do so. Your operator will then be able to update the fare or estimated fare for the journey. \nRemember \nYour operator is responsible for either agreeing a fare for the journey with the passenger or giving them an accurate estimate before a journey starts.'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: '7. Lost property'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'At the end of the journey, you should remind passengers to make sure they have not left anything behind. You should also check your vehicle for lost property after every journey. \nIf you find any lost property you should take it back to your operator. The operator will keep the property and make a record of it. By law your operator must keep a record of any items of lost property they hold. \nIf you find any lost property you should take it back to your operator.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '8. Suspicious items and behaviour'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Terrorist attacks can happen at any time or any place without warning.  \nItems left in your vehicle are likely to be items passengers have left behind, but if you are suspicious of an unattended item, call the police immediately on 999 and follow their instructions. \nBe aware of what is going on around you and of anything that seems different or unusual or doesn’t feel right, or anyone that you think is acting suspiciously. It could be someone you know, a passenger or even someone or something you notice when you are driving that doesn’t feel quite right. You can report your concerns about suspicious activity to the confidential police anti-terrorist hotline on 0800 789 321. \nDon’t worry about wasting police time or getting someone into trouble. The police will decide if the information you give is important and will treat it as private and confidential. \nYou should always report suspicious objects or vehicles so they can be checked. Don’t leave it to someone else to report it.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '9. When a booking cannot be carried out'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'When an operator has accepted a booking and you have agreed to carry it out, you should carry out that booking unless you have a very good reason. \nThere may be situations where you do not feel able or safe enough to take passengers, for example if they are carrying open bottles or cans of alcohol or anything dangerous or inflammable, or if they are acting in a violent or offensive way. If you do refuse to carry out a booking, be polite and explain why. This could help avoid a complaint. \nMake sure you tell your operator the full reasons why you did not carry out the booking. Because the operator accepted the booking, the operator is also responsible for either arranging for another driver to carry out the booking or to make it clear to the passenger that it has been cancelled. \nYou must not refuse to take passengers because they are disabled or they are travelling with assistance dogs. For more details, see Section 8: Being Aware of Equality and Disability.'));
  }

  void _buildTheoryForChapter4(List<TheoryPart> response) {
    response.add(
        TheoryPart(TheoryPartType.title, textData: 'Section 4 - Staying Safe'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'This section looks at how to keep you and your passengers safe. \nIt covers: \nDriver safety \nDrugs and alcohol \nMinimising conflict'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: '1. Driver safety'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Angry or violent behaviour when at work is never acceptable. \nYou should never accept any bad behaviour towards you for any reason. Any offensive or violent behaviour towards you because of your race, faith, sexual orientation, disability or gender identity is a hate crime. If you experience or witness this type of behaviour TfL urges you to report it to the police so that it can be fully investigated and action taken against the offender. \nTfL advises drivers to report incidents as soon as possible to the police on 101, or 999 in an emergency.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Remember \nIf a passenger in your vehicle becomes angry or violent you have a right to say that you will not accept that behaviour or, if that fails, to ask them to leave.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '2. Protecting yourself'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'To provide a safe service for your passengers and to protect you as a driver you should consider: \nDiscussing with your operator how they can help protect you from the possibility of aggressive or violent behaviour by a passenger. \nMaking sure your operator has given you the booking details, such as the passenger\'s name, pick up point and destination. \nYou could also consider: \nChecking the passenger’s name and destination before they get in the vehicle – this will help make sure the passenger doesn’t get into the wrong vehicle \nBeing clear with the passenger about exactly where you are taking them, the route there, how long it is likely to take and what the fare will be before the journey starts \nLetting the operator know about any change to the booking. The operator must then tell the passenger what the new fare will be \nCarrying a lone worker device or asking your operator to provide you with one \nAll these steps should reduce the risk of any disagreements. If a passenger is aggressive or violent, tell your operator immediately and give them the passenger’s full name and address if you know it.In an emergency, call the police on 999.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '3. Warning signs of possible aggressive behaviour'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Some behaviour is a sign that someone is becoming more angry and upset. Below are signs that someone might become aggressive. \nTapping their fingers \nCrossed arms \nHands held tightly in fists \nAggressive staring \nA raised voice \nAn angry expression \nA sudden change in behaviour \nA change to the voice \n'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Remember \nTrust your own feelings and never try to ignore these signs. If you feel concerned, act immediately. Remember, the earlier you notice a possible problem, the more choices you have to avoid it.'));

    response.add(
        TheoryPart(TheoryPartType.subtitle, textData: '4. Drugs and alcohol'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'When someone has taken drugs or has drunk alcohol, it can affect their ability to think or communicate clearly and their behaviour can be difficult to predict. In some cases they may become aggressive.  \nYour operator may have warned you about any possible problems when they gave you the booking (e.g. if the passenger sounds like they might be drunk). You can also judge the passenger’s physical and mental condition when you pick them up. If you have concerns then, contact your operator immediately. \nIf the passenger cannot communicate clearly to confirm their destination, or is unable to walk because of drink or drugs, you have the right to refuse to take them in your vehicle. In this situation, if possible, insist that a friend comes with them in your vehicle, or ask to speak to a friend of the customer by telephone to confirm the destination. \nIf the passenger is unconscious, extremely unwell or seems to be injured or in an emergency situation, and there is no-one else to help them, call the emergency services on 999 and stay with them until the services arrive.\nIf the passenger is being aggressive or violent, move somewhere that is safe for you but where you can still see the person until the emergency services arrive. Think about your personal safety first and do not put yourself at risk.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '5. Reducing the risk of violence in a difficult situation'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'There are certain things you can do to reduce the chance of someone being violent or aggressive towards you. For example, talking calmly and asking questions. \nThe table below shows which actions could help reduce the chance of someone being violent or aggressive towards you and which actions you should try to avoid.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Could help reduce the chance of someone being violent or aggressive'));
    response.add(TheoryPart(TheoryPartType.content,
        textData: '1. Explaining things without arguing'));
    response
        .add(TheoryPart(TheoryPartType.content, textData: '2. Talking calmly'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '3. Explaining procedures for dealing with unacceptable behaviour'));
    response.add(TheoryPart(TheoryPartType.content,
        textData: '4. Responding to the person’s concerns'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '5. Listening to what someone is saying without interrupting'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '6. Having a pre-planned way to excuse yourself from a difficult situation'));
    response.add(
        TheoryPart(TheoryPartType.content, textData: '7. Asking Questions'));
    response.add(
        TheoryPart(TheoryPartType.content, textData: 'Should try to avoid'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '1. Raising your voice so the person can understand you better'));
    response.add(TheoryPart(TheoryPartType.content, textData: '2. Arguing'));
    response.add(TheoryPart(TheoryPartType.content,
        textData: '3. Quickly dismissing someone’s concerns'));
    response.add(TheoryPart(TheoryPartType.content,
        textData: '4. Talking over someone'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '6. If you cannot reduce the risk of violence'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Sometimes you are not able to calm a situation. If that is the case you should: \nGet away from the aggressive person and exit the situation. If necessary, find somewhere safe to stop the vehicle, turn off the engine, take the keys then get out of the vehicle. \nConsider using a lone worker device to let someone know that you need help. \nIf an incident happens while you are away from your vehicle, get to your vehicle when possible and try to take time to calm down before you drive off \nAfter an incident: \nTry to talk about what happened with a friend, a colleague or your operator \nFind out if any support is available (there is advice on health and well being on the TfL website )Report the incident to help avoid it happening in future'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '7. What to do if you are attacked or assaulted'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'It is important for you to know where you can go for help if you are attacked or assaulted. Find out in advance what your operator’s reporting procedures are and who to go to after an incident like this. It is important to record and report incidents that almost happened, as well as ones that actually did happen. \nIf something happens to you, tell your operator and if necessary, also call the police and/or an ambulance depending on the incident. \nWhen you are recording an incident try and include: \nWhen and where the incident happened \nInformation about the attacker (name, address if known, description of clothing, age, gender) \n \nWhere possible you should also include the following details: \nWhether the attacker was one of your passengers \nBrief description of the incident \nAnything that might have caused the incident \nDetails of any witnesses \nType of incident (verbal threat, physical assault, written threat) \nDescription of any injuries \nAccount of the immediate action that was taken'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: '8. CCTV cameras'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Installing CCTV cameras into a vehicle can reduce threats and violence against drivers. Signs in the vehicle informing passengers that CCTV is used may also help to prevent aggressive or violent behaviour. You can buy a camera or rent one. Although this is an extra cost, having a CCTV camera may reduce insurance premiums. This is because a video recording can be useful evidence when there is a dispute with a passenger. \nThe Information Commissioner’s CCTV Code of Practice requires that signage must be displayed where CCTV is in operation. TfL requires all PHVs fitted with a CCTV system to display the sign shown below somewhere that is easy for passengers to see. \nThe vehicle owner can decide where to put this signage but it must be displayed somewhere that it does not block the driver’s view. It must also be as visible as possible to passengers as they enter the vehicle and while they are travelling in it.'));

    response.add(
        TheoryPart(TheoryPartType.image, imageData: AppImages.imgCCTVCameras));
  }

  void _buildTheoryForChapter5(List<TheoryPart> response) {
    response.add(TheoryPart(TheoryPartType.title,
        textData: 'Section 5 - Driver Behaviour'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'TfL expects all licensed drivers to offer Londoners and visitors a professional and safe service. Providing excellent customer service is an important part being a London PHV driver. This section explains how TfL expects drivers to behave towards passengers and other road users.'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: '1. Complaints'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'It is important that each time a passenger gets into a PHV they receive a high quality of service from their private hire driver. \nAlthough your operator will normally deal with complaints, passengers might contact the police or TfL directly. They might also contact TfL if they are not satisfied with the way the operator has dealt with their complaint. In these cases, TfL may carry out its own investigation. \nIf TfL does investigate a complaint that relates to you, we will provide you with the details of the complaint and ask for your comments. \nAs soon as you have had the opportunity to respond to the complaint and TfL has made any other necessary enquiries, TfL will tell you the result of that investigation. Remember TfL can only make a decision based on the information we receive, so it is important you respond to all our requests for information. \nIf a serious complaint is made against you, or if there are a number of complaints, or there appears to be a pattern of poor behaviour and all the ways to improve your behaviour have been tried but have failed, TfL may have to suspend or revoke your licence. \nOperators must report to the police any complaints that involve possible crimes, so that they can be investigated.\nOperators must keep details of all complaints made to them'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '2. Unacceptable behaviour'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'As a PHV driver, you offer an extremely important service to the travelling public. You have a responsibility to make sure your passengers feel safe when they travel in your vehicle. The way that you interact with them will affect the way they will feel about their journey with you. It is important that you are professional and deal with passengers in a way that makes them feel at ease. \n# You should never make comments or jokes about someone’s age, race, religion, disability, sexual orientation or gender identity. Drivers who behave in an unacceptable way will have action taken against them by TfL and/or the police. \nYou should never use a passenger’s personal contact details to start communicating with them about anything other than the booked journey.Contacting a passenger for personal or social reasons is unacceptable and a misuse of the passenger’s personal information. \n3. Entering the back of your vehicle \nIf you get into the back seat, you risk making your passengers uncomfortable and your actions may be misunderstood or considered inappropriate. \n#. Other than in an emergency, you must not get into the back seat of your vehicle while you have passengers on board. \nIf your passenger is ill, or has a disability, and asks you to help them enter or leave your vehicle, make sure you check exactly what help they are asking you for, for example to take hold of your arm to support them. Keep any physical contact to the minimum required to give the help your passenger asks for.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If your passenger is seriously ill: \nyou should call the emergency services on 999 immediately. \nyou should not try to physically check the passenger or administer first aid yourself unless you are following the instructions of the emergency services, or you have had appropriate first aid or medical training.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '4. Unacceptable sexual behaviour'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '# No type of sexual behaviour between you and a passenger is ever acceptable, even if both of you agree to it. \nTfL takes this issue extremely seriously. TfL or the police will fully investigate all complaints and reports, and they will take appropriate action. You will lose your licence if you are found to have acted in an unsuitable way towards a passenger.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You should never: \nTouch a passenger in an unacceptable way. You should avoid any physical contact with a passenger unless completely necessary (such as helping a person who needs assistance into your vehicle) to reduce any misunderstanding or complaints against you. Touching someone without their permission could be a sexual assault and will be investigated by the police.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You should also never: \nLook at or speak to a passenger in a way that makes them feel uncomfortable, for example staring at any part of their body \nMake any sexual remarks or comments about a passenger’s appearance or clothing \nSuggest having sex with a passenger \nOffer or accept sex or sexual activity in place of a fare \nEngage in conversation of a sexual nature. This includes asking questions about someone’s sex life or telling sexual jokes. \nWatch, display or share pornographic or sexual pictures, or any other sexual material. \nCommit any other sexual offence'));
  }

  void _buildTheoryForChapter6(List<TheoryPart> response) {
    response.add(TheoryPart(TheoryPartType.title,
        textData: 'Section 6 - Driving and Parking in London'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'This section gives general information on parking and driving in London. It does not replace the need for you to be aware of your responsibilities under The Highway Code.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You must remember that: \nPHVs are not allowed to drive in bus lanes \nPHVs are not allowed to park, wait, drop off or collect passengers on a taxi rank. \nPHVs are not allowed to use or park on electric taxi charge points. \nA PHV is not a taxi.  \nIf a road sign shows that access is for a taxi then you are not allowed access.Here are two examples:'));

    response
        .add(TheoryPart(TheoryPartType.image, imageData: AppImages.imgParking));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '1. Stopping and waiting'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Private hire drivers can stop to pick up or drop off passengers in many areas where there are rules in place to limit waiting or stopping. You need to remember that:  \nPHV drivers should not stop in any place where they might stop other vehicles moving or be a danger to other road users.\nPHV drivers must not stop on zigzag lines(for example, by pedestrian crossings, outside schools) \nYou should check what signage is displayed about stopping or waiting and make sure you understand and follow the instructions.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'On single and double yellow lines\nIn places where loading is not allowed (shown by markings on the kerb) \nIn most parking bays \nIn most bus lanes \nOn single and double red lines \n'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            '#PHVs can, however, stop on a red route to wait for passengers to use a cashpoint between the hours of 22:00 and 06:00 only but for no longer than 5 minutes \nYou can stop in the above locations only long enough for the passengers to get in or out of your vehicle. This includes the time to help passengers who need assistance, for example wheelchair users, including the time needed to make sure the wheelchair is in the right position and safely secured \nYou should not stop on taxi ranks, even when picking up or dropping off passengers \nIf there are waiting or parking restrictions, you cannot stop for longer than is needed for the passenger to get in or out of the vehicle. (There is no general permission that allows you to leave your vehicle to help a passenger to or from a building. However some councils understand and accept that this is an important part of your job. If your passenger needs help, you should spend only a short time away from your vehicle, if possible, and make a note of the passenger’s details/booking, just in case you get a Penalty Charge Notice (PCN). It will be down to the council who issued the PCN to decide whether to accept this evidence and cancel the PCN \nIf you are not picking up or dropping off a passenger, you may get a PCN if you wait somewhere where there are restrictions. This can happen even if you have arrived early for a booking or the passenger is late, or if a passenger has asked you to stop and wait while they visit a shop or use a cashpoint \nYou should not leave your engine running while you are waiting. If your engine is running while you are parked or waiting you are polluting the environment and this can be illegal on a public road \nNever drop passengers off in the middle of the road, even if your vehicle is stopped due to traffic. You should always get close to the kerb \n'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '2. Bus lanes and bus stops'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You can pick up or drop off passengers in most bus lanes, even though you are not allowed to drive in them, but you should avoid doing this if possible.  \n You must: \nEnter and leave the bus lane in the most direct and safe way. Pay careful attention to cyclists and motorcyclists who are able to use bus lanes and to pedestrians and bus passengers that may be getting off the bus and crossing the road. \nNot stop at \'bus stop clearways\' marked with a wide yellow line by the kerb. On red routes, you cannot stop at bus stops marked with a wide red line by the kerb. You should try not to stop at other red route bus stops to avoid delaying or obstructing buses. \nRemember that only licensed taxis (black cabs) can use bus lanes – PHVs are not allowed to. \n#You should avoid picking up or dropping off passengers at bus stops as this can delay buses and may not be allowed at some bus stops.'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: '3. Taxi ranks'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Taxi ranks can only be used by licensed London taxis (black cabs), not by PHVs. If you park or wait on a taxi rank you may be fined and TfL may also take licensing action against you. This could include suspending or revoking your PHV driver’s licence. \nElectric taxi charging points \nElectric taxi charging points can only be used for charging electric taxis. They cannot be used for charging PHVs. \nIf you park or wait on an electric taxi charging point, or use it to charge a PHV, you may be fined and TfL may also take licensing action against you. This could include suspending or revoking your PHV driver’s licence.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '4. Penalty Charge Notices (PCNs)'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You can get a PCN for: parking offences, driving in a bus lane, banned turns or movements (e.g. an illegal U-turn) or blocking a yellow box junction.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '5. Congestion Charging'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'PHVs entering the Congestion Charge zone need to pay the daily charge unless they have an exemption.\n You can find information about the times and days when you need to pay the Congestion Charge, and the area it covers on our website \n.If your PHV is designate as wheelchair accessible, you will not have to pay the Congestion Charge if you are entering the zone to carry out a booking from a London licensed PHV operator. You can check if your vehicle has been designated as wheelchair accessible on the TfL website.\n[1]Designated vehicles are those listed by TfL under section 167 of the Equality Act'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '6. Ultra Low Emission Zone'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'To help improve air quality, an Ultra Low Emission Zone (ULEZ) operates in London. You can find information about the times and days when you need to pay the ULEZ charge, and the area it covers on our website. \nPHVs need to meet the ULEZ emissions standards or their drivers must pay a daily charge to drive within the zone:\nPetrol PHVs must be Euro 4 \nDiesel PHVs must be Euro 6 \nThe emissions standard of a vehicle can usually be worked out from the date of its first registration as new, which is shown on the vehicle\'s registration document known as the V5C.\nPHVs registered as wheelchair accessible by TfL are exempt from the ULEZ charge.'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: '7. Red routes'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'These are the main roads in London and are marked with red lines by the kerb and, where required, with signs. PHV drivers can pick up or drop off passengers on single or double red lines, but PHV drivers must not wait for a passenger where restrictions apply, even if they have arrived early for a booking or the passenger is late or wants to visit a shop. \nThe only exception is that we do allow PHVs to stop on the red route to wait for passengers to use a cashpoint between the hours of 22:00 and 06:00 only but for no longer than 5 minutes \nPlease note that you must never, for any reason, stop within pedestrian clearways, zig-zag lines, bus stops with wide red lines, or any place where your vehicle would cause an obstruction or any danger to other road users. \nSome parts of red routes are marked for parking. Parking bays can be identified by a \'P\' on the signs that accompany them. The signs will tell you when parking is allowed, how long vehicles can be parked and how soon a vehicle can stop again in the same section of road.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'It is important to pay attention to the signs and particularly the time limits and restrictions shown on them. PHVs can pick up or drop off passengers and can park or wait in a parking bay as long as they obey these limits. \nPHV drivers can pick up or drop off passengers on single or double red lines, but PHV drivers must not wait for a passenger where restrictions apply.'));

    response.add(
        TheoryPart(TheoryPartType.image, imageData: AppImages.imgParkingRoute));
  }

  void _buildTheoryForChapter7(List<TheoryPart> response) {
    response.add(TheoryPart(TheoryPartType.title,
        textData: 'Section 7 - Safer Driving'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'PHV drivers need to keep a careful watch on the roads at all times and be able to interact safely with all other road users, especially those that are more vulnerable such as pedestrians, cyclists and motorcyclists.\nThis section tells you about the how to maintain the highest standards of driving. More advice on driving safely is on the TfL website.'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: '1. Obey the law'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'As a PHV driver, you are expected to be fully aware of and to obey the rules of the road, as explained in The Highway Code. You should avoid behaviour that causes any danger to you, your passengers and other road users.\nMost collisions in London are caused by a small number of easy-to-avoid behaviours. These include:\nSpeeding or driving too fast for the conditions\nMaking dangerous manoeuvres\nGetting distracted\nNot following the rules of the road\nYou need to be aware of your responsibilities as a professional driver and think about the topics in the sections below.'));

    response.add(TheoryPart(TheoryPartType.subtitle, textData: 'Safe speeds'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Drive at a speed within the speed limit and one that is appropriate for the situation, environment and weather conditions.\nThe faster you drive, the less time you have to do something to avoid a collision. The resulting injuries also become more serious as speed increases.'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: 'Safe manoeuvres'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Think about the manoeuvres you make, and make sure they are safe. This includes things like looking carefully when pulling out of junctions, turning across traffic or passing cyclists or motorcyclists.\nCareless or dangerous driving is a serious offence with heavy penalties.'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: 'Concentration'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You need to focus on the road and be able to react quickly. Don’t get distracted by mobile phones and other electronic devices, music or passengers.\nIf you do need to answer or make a call you will need to stop safely, park your vehicle and turn the engine off.\nDistractions can make you less aware of what is happening on the road, and affect your judgement so your decision making abilities are reduced.\nRemember it is also illegal to use a hand-held phone or similar device when you are driving unless you are calling the emergency services in an emergency and it is unsafe or impractical to stop. This includes when you are stopped in a queue of traffic e.g. at traffic lights, delays, etc.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: 'Use of alcohol or drugs'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You must never drive while you are under the influence of drugs or alcohol.\nThe police test for drug and alcohol use at the roadside to catch those who break the law.'));

    response.add(
        TheoryPart(TheoryPartType.subtitle, textData: 'Prescription medicine'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you are taking prescription medicine you must check with your doctor that it is safe for you to drive.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: 'Following traffic laws before a journey begins'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You need to know about and follow the laws on the safe use of vehicles e.g. laws that require you to have insurance, a current MOT certificate, a driving licence, wear a seatbelt and not drive a faulty vehicle.\nAll drivers must make sure that their vehicle is maintained to the required standard.\nIt is important that you are aware of the rules regarding passengers wearing seatbelts in PHVs.\nAll adults must wear a seat belt and drivers should encourage adult passengers to wear a seatbelt for their own safety. Drivers must also make sure that all children are correctly seated and restrained.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Remember\nDrivers are responsible for making sure that all children under 14 years of age wear seatbelts or sit in an approved child car seat.\nIf the correct child seat is not available, children can travel without one- but only if they travel rear seat:\nEnd wear an adult seat belt if they are 3 or older.\nWithout a seat belt if they are under 3\nThe police keep a close watch on London’s roads 24 hours a day and will identify drivers who choose to break the law. \nIf you fail to obey any of the above rules, you may get a fixed penalty notice (FPN) or be prosecuted – this can result in a fine and penalty points on your licence. It may also result in you being banned from driving. You could also lose your PHV driver’s licence.\nBeing aware of other road users\nTfL expects all professional drivers to be fully aware of other road users. In particular those people who are the most vulnerable:\nPedestrians: Be aware of pedestrians suddenly stepping into the road and give way to pedestrians on side roads.\nMotorcyclists: Be aware of motorcyclists at all times but especially when you are turning or in slow moving traffic.\nCyclists: Be aware of cyclists at all times but especially when you are turning, in slow moving traffic or when you are pulling away from traffic lights. Make sure you give cyclists enough room when you overtake them'));

    response.add(
        TheoryPart(TheoryPartType.subtitle, textData: '2. Windscreen vision'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'In clear sight\nAnnex 6 of the Highway Code, which deals with vehicle maintenance, says \'Windscreens and windows must be kept clean and free from obstructions to vision\'. That means you should not put or fix anything onto your windscreen that will stop you being able to see the road ahead. This includes mobile phones, sat navs and other devices that will reduce your vision:'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'These pictures, based on photographs taken by the City of London Police, show just how much your area of vision is reduced by having devices attached to your windscreen.'));

    response.add(TheoryPart(TheoryPartType.image,
        imageData: AppImages.imgWindscreenVision1));
    response.add(TheoryPart(TheoryPartType.image,
        imageData: AppImages.imgWindscreenVision2));
    response.add(TheoryPart(TheoryPartType.image,
        imageData: AppImages.imgWindscreenVision3));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Be cradle careful\nBefore starting any journey, you should make sure you have a clear view through the windscreen and windows of your vehicle and that no devices or signage reduce or obstruct your view.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you put a cradled device (such as a mobile phone or sat nav) on the area on your windscreen that is covered by your windscreen wipers (known as the ‘swept area’), you are committing an offence. If you are prosecuted, you may be fined and get penalty points on your driving licence.\nDriving conditions can change quickly and dangers such as pedestrians suddenly stepping in front of you, or bikes coming out of side streets, mean you need to have a clear view of the road.  If your windscreen is covered in devices, you increase your chances of getting distracted or not seeing dangers in time to avoid them. You must make sure that you put any devices in positions that do not reduce how much you can see.'));

    response.add(TheoryPart(TheoryPartType.image,
        imageData: AppImages.imgWindscreenVision4));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '3. Other things to consider'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Being tired: Tiredness can have a similar effect on a driver as drinking alcohol, and can result in death or serious injury. Plan your day to include regular breaks from driving and do not begin a journey if you are already tired.\nWeather conditions: You should change your driving behaviour when the weather conditions change, so that you are always driving safely.  If it suddenly starts to rain heavily or there is thick fog, reduce your speed.\nDriving at night: You should pay particular attention when driving at night because pedestrians, cyclists and motorcyclists may be more difficult to see then.'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: '4. Cycle safety'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Cycle safety \nPHV drivers spend a lot of time on the roads and are almost twice as likely as private car drivers to be involved in a collision that results in the death or serious injury of a cyclist. Because of this, it is very important that you follow the advice below so you can reduce the risk of a collision and help make sure that everyone travels safely.\nTop tips:\nAlways check for cyclists, pedestrians and motorcyclists who may be moving, even if most vehicles are stopped in traffic.\nLook out for cyclists, especially when checking your mirrors before indicating to go left or right, or changing your speed or direction.\nCheck over your shoulder for cyclists and other road users before opening your door to make sure it doesn’t swing out in front of them.\nUse your indicators when turning or changing lanes, even if you don’t think anyone is near you\nIndicate well in advance to allow others to react.\nMake sure your indicator is off once you have completed your manoeuvre, to avoid confusing cyclists and other road users.\n'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Give cyclists room\nKeep a safe distance from cyclists and don’t try to overtake when there is not enough space. Give as much space as you would for another car. If a cyclist is using the middle of the lane, wait patiently until you can pass safely.'));

    response
        .add(TheoryPart(TheoryPartType.image, imageData: AppImages.imgCyclist));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Leave room for cyclists at traffic lights. Drivers should not enter the advanced stop line box when the light is red'));

    response.add(
        TheoryPart(TheoryPartType.subtitle, textData: '5. Vehicle safety'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'As a professional driver you are responsible for checking your vehicle is safe and legal to drive.  \nDriver\'s compartment  \nFor example, in the driver\'s compartment you should check that the horn works.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Other things to check include: \nYour seat and seatbelt are in good condition, are secure and you can adjust them as you need \nThe steering wheel is secure and in good condition \nThe clutch and brake pedals have anti-slip covers \nThe handbrake is in good working condition Driver warning lights do not light up when the engine is started \nThe indicators are working correctly \nThe windscreen washers and wipers are in good condition \nAny devices for opening and closing the driver and front passenger windows work correctly You can see in all the mirrorsYou can see all the mirrors'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Passenger compartment \nThis should be clean and all equipment in it must be in good working order, such as the seat belts fitted to the passenger seats. \nThis also includes: \nUpholstery, headlining, carpets and door trims \nPassenger courtesy lights \nWheelchair safety belts/seat belts (if applicable) \nAll doors and door locking mechanisms \nVehicle heater system \nNo smoking signs \nCCTV signage is displayed in a prominent position (this is only required where CCTV is installed in the vehicle) \n'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Wheels and tyres  \nTyres must be the correct size, speed and weight rating for the make and model of your vehicle. You should make sure all wheel nuts are in place and secure.  \nTyres must be free from:  \nCuts, lumps, bulges and tears  \nExcessive or uneven tyre wear  \nExcessive damage to the wheel rim  \nTyre wear bar indicators are positioned around the tyre. If the tread pattern has worn down to the level of the indicators, then you must replace the tyre.  \n'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Outside the vehicle  \nMake sure there are no signs of fluids (oil, brake fluid) leaking from under the vehicle on to the ground.  \nYou should check:  \nAll external lights and reflectors are there and secure, undamaged and working  \nBody panels have not been badly repaired  \nThere is no evidence of serious damage to the external body panels  \nThere is no serious rusting or corrosion resulting in sharp edges  \nAll windows are clean, undamaged and free from unapproved signage or advertising material  \n'));
  }

  void _buildTheoryForChapter8(List<TheoryPart> response) {
    response.add(TheoryPart(TheoryPartType.title,
        textData: 'Section 8 - Being Aware of Equality and Disability'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            'TfL is committed to improving transport in London by making it more accessible, safer and reliable for all. Public transport plays an important role in opening up opportunities by providing access to education, employment and other essential services. It helps people stay in touch with family and friends and allows many people to live independently.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            'This section tells you about your responsibilities and how to provide the best service to all your passengers.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '. Assisting passengers'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'TfL believes it is important to provide a public transport system which all people can use, so that older and disabled people have the same opportunities to travel as all other people. TfL expects PHV drivers to deliver a high standard of customer service to all passengers, whatever their needs. However, we know that some passengers may need more help. This section gives you information, advice and tips on what you can do to help disabled passengers and other passengers that require assistance.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'For example, if the passenger is visually-impaired and asks you to guide them to the vehicle, stand by the person’s side and allow them to take hold of your arm/elbow so you can guide the customer along. Do not take hold of the passenger and pull or push them in a particular direction.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Here are some more tips to help provide the best service to your passengers:'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Always ask your passengers if they need any help and wait for your offer to be accepted. Listen to any requests and remember that everyone is different'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Be ready to give disabled and older passengers some help. This could be as simple as writing things down for them, giving them a little extra time, facing them so they can see your lips as you speak, or speaking loudly and clearly if they have problems hearing you'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Talk directly to the older or disabled person rather than to the person with them if they are travelling with someone.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Tell the passenger where they are going and let them know about any possible dangers, such as pavement kerbs, doors opening towards or away from them and slopes going up or down. This will help prevent accident and injury.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'When you arrive at your destination, tell the passenger the location, then offer to assist them out of the vehicle and to guide them to a safe place before leaving them.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Clearly tell the passenger how much the fare is. When you give change to passengers who are visually impaired, it is important to count out the coins and notes into their hand.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Offer to help count out the change if a passenger seems to be having problems.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Always have a pen and paper with you so that you can write things down. This can help passengers who have a   problem hearing or passengers who do not speak much English.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you drive a wheelchair accessible vehicle,make sure the equipment is in good working order and therefore available to use at any time.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Be careful of where you pick up and drop off wheelchair users. Avoid places where the pavement is on a slope.Disabled or older passengers may need more time or help to get in and out of your vehicle. For their safety, be patient and make sure they are comfortable and have their seatbelt fastened before you start the journey'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You can also help by asking the passengers if they have all their belongings with them before you set off and when you arrive at their destination'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'During the journey, visually-impaired passengers in particular should be told about any delays, or changes to the route. This is also a good thing to do with any elderly passengers or passengers who have a learning disability, as they might get worried or upset if there is a change to the route they expected to take.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Not all disabilities are easy to see, so offer, or be prepared to help any passenger.'));

    response.add(
        TheoryPart(TheoryPartType.subtitle, textData: '2. Equality Act 2010'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'It is illegal to treat anyone unfairly based on any of the characteristics protected under the Equality Act.It is unacceptable for you as a PHV driver, or for any of your customers, to use language or behave in a way that discriminates against any person. As a PHV driver you are expected to treat all passengers in a professional and respectful way without making a judgement about any person’s'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'The following characteristics are protected under the Equality Act:'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Age \nDisability \nGender reassignment \nMarriage and civil partnership \nRace \nReligion or belief \nSex \nSexual orientation \nPregnancy and maternity \n'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '3. Designated wheelchair accessible PHVs'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you drive a designated wheelchair accessible PHV, you have certain duties under the law . Your operator should be aware that the vehicle you are driving is a designated wheelchair accessible vehicle.\nIf your vehicle is a designated wheelchair accessible PHV, you must:\nCarry the passenger while they remain in the wheelchair and make sure the safety belts are attached to the wheelchair to keep it in a safe position.\nNot charge extra because a passenger uses a wheelchair.\nCarry the wheelchair safely and securely if the passenger chooses to sit in a passenger seat.\nMake sure the passenger is carried safely and in reasonable comfort.\nOffer the passenger any help that is reasonably required.'));

    response.add(TheoryPart(TheoryPartType.subtitle, textData: 'Exemptions'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'A driver can only get permission to not carry wheelchairs for medical reasons. If a driver cannot carry out the duties of section 165 of the Equality Act because the driver’s poor health or fitness makes it impossible or unreasonable, an exemption certificate may be given to the driver. You will need to contact TfL to apply for an exemption certificate and, if granted, you will need to display an Exemption Notice in the windscreen of your vehicle.'));

    response.add(
        TheoryPart(TheoryPartType.subtitle, textData: '4. Assistance dogs'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Section 170 of the Equality Act says that PHV drivers must accept passengers with assistance dogs and must allow the assistance dog to sit in the footwell, next to the passenger.\nAssistance dogs are highly-trained ‘working’ animals so should not be treated like pets. Do not stroke or feed assistance dogs or distract them in any way.\nThere is a wide range of assistance dogs. You can sometimes see what type of assistance a dog provides by looking at the colour of the jacket it is wearing. Remember, though, that an assistance dog may not always wear a jacket.\nThe pictures below are of some of the dogs you might come across. Please remember that assistance dogs are not always the same breed as shown in the pictures and not all assistance dogs have a jacket to identify them.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            'PHV drivers and operators cannot refuse or charge a passenger extra because they have an assistance dog.'));

    response.add(
        TheoryPart(TheoryPartType.image, imageData: AppImages.imgAssistantDog));

    response.add(
        TheoryPart(TheoryPartType.subtitle, textData: 'Dogs and Islamic law'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'In 2002, the Shariat Council confirmed that trained assistance dogs may accompany disabled people in PHVs managed or driven by Muslims. The council’s guidance helps to make religious law clear, and to prevent any possible conflict with secular law.'));

    response.add(TheoryPart(TheoryPartType.subtitle, textData: 'Exemptions'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'A PHV driver can only get an exemption from carrying assistance dogs for medical reasons.\nIf a driver has a medical condition, such as asthma which gets worst when near dogs, or if the driver is allergic or has a fear of dogs (a phobia), it may be possible for them to get an exemption. You will need to contact TfL to apply for an exemption certificate and, if granted, you will need to display an Exemption Notice in the windscreen of your vehicle'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: ' 5. Complaints'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'We will investigate any complaint we receive about a PHV driver breaking the Equality Act.\nIf there is enough evidence of an offence being committed and it is in the public interest to do so, we will always prosecute the driver.\nIf you are convicted of an offence under the Equality Act we will decide how suitable you are to be a licensed PHV driver and we may suspend or revoke your PHV driver’s licence.'));
  }

  void _buildTheoryForChapter9(List<TheoryPart> response) {
    response.add(TheoryPart(TheoryPartType.title,
        textData: 'Section 9 - Safeguarding Children and Adults at Risk'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            'Safeguarding means protecting children and adults at risk (sometimes called vulnerable adults) from harm and abuse.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            'This section gives you information on how to keep your passengers safe. Please read through the sections below.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '1. Who is a child or an adult at risk'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'According to the law, a child is a person under the age of 18. All children are vulnerable to harm and abuse because of their age. Children are less able to protect themselves and are dependent on adults. This makes them vulnerable to being exploited or abused.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'An adult at risk is anyone over the age of 18 who is in need of extra care and support. An adult may be at risk of harm or abuse because they are unable to protect themselves. This might be because of their age, a disability or mental illness.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '2. Carrying unaccompanied children in your vehicle'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If your passenger is an unaccompanied child, make sure your operator knows, and that you know the name of the adult who will be meeting the child at the end of the journey. Your operator should give you that information.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '3. Carrying children and adults at risk in your vehicle'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'As a driver, you may have to transport children or adults who are at risk. You may come into contact with passengers that are being trafficked, exploited, abused or who are in need of help in some other way.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You can help with this and you should know what to do if you have concerns that a person is at risk. You might notice things which do not seem quite right and you could be in a position to report something to the police that may help protect someone at risk.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Make sure your behaviour with all passengers, including children and adults at risk, is appropriate and professional at all times. Be aware of how your actions could affect others.'));

    response
        .add(TheoryPart(TheoryPartType.subtitle, textData: '4. County lines'));

    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Criminal exploitation is also known as county lines.'));

    response.add(
        TheoryPart(TheoryPartType.content, textData: 'What is county lines?'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'This is when gangs and organised crime groups use children and young adults to sell drugs.These children and young adults are often forced to travel across counties for example, by train or in taxis and private hire vehicles, and they use mobile phone ‘lines’ to keep in contact with individuals in the drugs trade.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Signs that a child or vulnerable person is at risk may include:'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Young or vulnerable people being picked up and taken to hotels or suspected brothels particularly at odd times of the day and night'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'A young person travelling to meet someone they don’t know, perhaps who they have met online'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'A young person or adult who shows signs of being abused, harmed or neglected'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Adults putting a young person into your vehicle who may be under the influence of alcohol or drugs'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'A child or young person who looks concerned or frightened in the company of adults'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'An adult or young person who may be poorly dressed/unclean or look like they do not get enough food'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'An adult who seems to be controlled by someone else or is having decisions made for them by another adult'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you think you have seen a child or adult at risk who needs help or is suffering from any signs of abuse or if they\'ve told you directly, you must report it to your operator and the police.It is helpful to keep a note (written or recorded) of the incident or situation that you are worried about. Include details such as dates and times, a description of what happened, the name, address and a physical description of the people involved. You can then give these details to the police.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData: 'As a driver it is important to:'));

    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Be aware of children and adults at risk'));

    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Be concerned about their well being'));

    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Listen to what they tell you'));

    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Reassure them by being professional, kind and considerate'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Report concerns to your PHV operator or the police using 101. In an emergency, call 999.'));

    response.add(TheoryPart(TheoryPartType.content, textData: 'Other support'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'In most situations you should report any incidents or concerns to your PHV operator/controller and the police by calling 101. If it is an emergency call 999.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            'These are some other options if you do not feel it is appropriate to report the matter to the police:'));

    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Crimestoppers (an anonymous service) - 0800 555 111.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'National Society for the Prevention of Cruelty to Children (NSPCC) - 0808 800 5000'));

    response.add(TheoryPart(TheoryPartType.content,
        textData: 'Modern Slavery Helpline - 08000 121 700'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'REMEMBER - You do not need to give your details and can report anonymously, but the more information you can give the better.'));
  }

  void _buildTheoryForChapter10(List<TheoryPart> response) {
    response.add(
        TheoryPart(TheoryPartType.title, textData: 'Section 10 - Ridesharing'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            'Ridesharing is when people who do not know each other pay separate fares and travel together in the same vehicle.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Safety, Equality and Regulatory Understanding requirement that applies to all existing licence holder and applicants.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData: '1. Ridesharing overview'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'All ridesharing journeys must be booked with a licensed London PHV operator. As a London PHV driver, you can only carry out ridesharing bookings that you have received from a licensed London PHV operator.'));
    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Ridesharing can potentially introduce some safety risks for passengers.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'It is possible that ridesharing might happen if, for example, two people have a similar route to and from work and travel at similar times. They may choose to book a ridesharing PHV and travel with someone they don’t know. In cases like this, one passenger could be put at risk if the other passenger learns things about them such as:'));

    response.add(
        TheoryPart(TheoryPartType.content, textData: '# their home address'));

    response
        .add(TheoryPart(TheoryPartType.content, textData: '# where they work'));

    response.add(
        TheoryPart(TheoryPartType.content, textData: '# their daily routines'));

    response.add(TheoryPart(TheoryPartType.content,
        textData: '# whether they live alone or not'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'A stranger knowing information like this may make a passenger vulnerable to crime.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Another possible problem is that a passenger may book a ride-sharing journey by mistake. If you stop to collect a second passenger and the first passenger was not expecting you to, it could result in an argument.'));

    response.add(TheoryPart(TheoryPartType.subtitle,
        textData:
            '2. To try to reduce these problems, it is always a good idea to:'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Confirm with each separate passenger that they have booked a ride-share as soon as you pick them up'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Explain how many other people you will pick up and the predicted route'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Let them know if you have to change the predicted route or pick up new passengers during the journey '));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Tell the passenger how long it is likely to take to get to their destination'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'Make sure the passenger knows what the cost is likely to be'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'It may also be a good idea to say to passengers that if they feel uncomfortable at any point, they can ask to get out of the vehicle and they can arrange for a non rideshare PHV vehicle to meet them at a point along your route.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'You should not share the personal details of one passenger with any other passenger.'));

    response.add(TheoryPart(TheoryPartType.content,
        textData:
            'If you work for a PHV operator who offers ridesharing services you should talk to them about ridesharing training for PHV drivers, as the operator should provide this.'));
  }
}
