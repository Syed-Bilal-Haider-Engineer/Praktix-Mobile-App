import '../../models/program.dart';
import '../../models/expert.dart';
import '../../models/workshop.dart';
import '../../models/opportunity.dart';
import '../../models/certificate.dart';
import '../../models/user.dart';

class MockData {
  MockData._();

  static const programs = <Program>[
    Program(
      id: 'prog-1',
      title: 'AI for Managers',
      description:
          'Learn how to leverage AI tools and strategies to drive business decisions, optimize workflows, and lead AI adoption in your organization. Designed for non-technical leaders.',
      duration: '8 weeks',
      certificateIncluded: true,
      outcomes: [
        'Understand AI fundamentals for business',
        'Build AI adoption roadmaps',
        'Evaluate AI tools and vendors',
        'Lead cross-functional AI initiatives',
        'Measure ROI of AI investments',
      ],
      category: 'AI & Leadership',
      imageUrl:
          'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80',
      enrolled: true,
      progress: 0.65,
    ),
    Program(
      id: 'prog-2',
      title: 'AI for Developers',
      description:
          'Master practical AI development with Python, machine learning frameworks, and deployment pipelines. Build real-world AI applications from scratch.',
      duration: '12 weeks',
      certificateIncluded: true,
      outcomes: [
        'Build ML models with Python & TensorFlow',
        'Implement NLP and computer vision solutions',
        'Deploy AI models to production',
        'Work with LLMs and prompt engineering',
        'Create portfolio-ready AI projects',
      ],
      category: 'AI & Engineering',
      imageUrl:
          'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=800&q=80',
    ),
    Program(
      id: 'prog-3',
      title: 'AI for Healthcare',
      description:
          'Explore AI applications in healthcare — from diagnostic tools to patient care optimization. Learn ethical AI practices for medical settings.',
      duration: '10 weeks',
      certificateIncluded: true,
      outcomes: [
        'Apply AI to medical imaging analysis',
        'Understand healthcare data privacy (HIPAA/GDPR)',
        'Build predictive health analytics models',
        'Navigate AI ethics in clinical settings',
        'Collaborate with healthcare professionals',
      ],
      category: 'AI & Healthcare',
      imageUrl:
          'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&q=80',
    ),
    Program(
      id: 'prog-4',
      title: 'Cybersecurity Internship',
      description:
          'Hands-on cybersecurity internship with real company projects. Learn penetration testing, threat analysis, and security architecture under expert mentorship.',
      duration: '16 weeks',
      certificateIncluded: true,
      outcomes: [
        'Conduct vulnerability assessments',
        'Implement security best practices',
        'Respond to security incidents',
        'Build a security portfolio',
        'Earn industry-recognized credentials',
      ],
      category: 'Cybersecurity',
      imageUrl:
          'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800&q=80',
      enrolled: true,
      progress: 0.30,
    ),
  ];

  static const experts = <Expert>[
    Expert(
      id: 'exp-1',
      name: 'Dr. Sarah Chen',
      title: 'AI Research Lead',
      specialization: 'Machine Learning & NLP',
      bio:
          'Dr. Chen has 15+ years of experience in AI research and industry applications. She has led AI teams at Fortune 500 companies and published 40+ papers on natural language processing.',
      experience: '15+ years in AI research and industry',
      imageUrl:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&q=80',
      programIds: ['prog-1', 'prog-2'],
    ),
    Expert(
      id: 'exp-2',
      name: 'Marcus Weber',
      title: 'Cybersecurity Director',
      specialization: 'Penetration Testing & Security Architecture',
      bio:
          'Marcus is a certified ethical hacker with extensive experience securing enterprise systems across Europe. He mentors interns through real-world security challenges.',
      experience: '12+ years in cybersecurity',
      imageUrl:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&q=80',
      programIds: ['prog-4'],
    ),
    Expert(
      id: 'exp-3',
      name: 'Dr. Amira Hassan',
      title: 'Healthcare AI Specialist',
      specialization: 'Medical AI & Health Informatics',
      bio:
          'Dr. Hassan bridges the gap between clinical practice and AI innovation. She has implemented AI diagnostic tools in hospitals across the GCC region.',
      experience: '10+ years in healthcare technology',
      imageUrl:
          'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400&q=80',
      programIds: ['prog-3'],
    ),
    Expert(
      id: 'exp-4',
      name: 'James Okafor',
      title: 'Tech Career Coach',
      specialization: 'Career Development & Leadership',
      bio:
          'James has helped 500+ professionals transition into tech careers. He specializes in portfolio building, interview preparation, and career strategy.',
      experience: '8+ years in career coaching',
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80',
      programIds: ['prog-1', 'prog-2', 'prog-3', 'prog-4'],
    ),
  ];

  static final workshops = <Workshop>[
    Workshop(
      id: 'ws-1',
      title: 'Introduction to Prompt Engineering',
      description:
          'Learn the fundamentals of crafting effective prompts for LLMs.',
      date: DateTime.now().add(const Duration(days: 3)),
      time: '14:00 - 16:00 CET',
      speaker: 'Dr. Sarah Chen',
      imageUrl:
          'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=400&q=80',
      isOnline: true,
    ),
    Workshop(
      id: 'ws-2',
      title: 'Building Your Tech Portfolio',
      description:
          'A hands-on workshop on creating portfolio projects that impress hiring managers.',
      date: DateTime.now().add(const Duration(days: 7)),
      time: '10:00 - 12:00 CET',
      speaker: 'James Okafor',
      imageUrl:
          'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400&q=80',
      isOnline: true,
    ),
    Workshop(
      id: 'ws-3',
      title: 'Cybersecurity Threat Landscape 2026',
      description:
          'Stay ahead of emerging threats with insights from industry experts.',
      date: DateTime.now().add(const Duration(days: 14)),
      time: '16:00 - 18:00 CET',
      speaker: 'Marcus Weber',
      imageUrl:
          'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=400&q=80',
      isOnline: false,
    ),
  ];

  static const opportunities = <Opportunity>[
    Opportunity(
      id: 'opp-1',
      title: 'Junior AI Engineer',
      company: 'TechVision GmbH',
      location: 'Berlin, Germany',
      type: 'Full-time',
      description:
          'Join our AI team to build next-generation NLP solutions for enterprise clients.',
      imageUrl:
          'https://images.unsplash.com/photo-1497366216548-37526070297c?w=400&q=80',
      isSaved: true,
    ),
    Opportunity(
      id: 'opp-2',
      title: 'Cybersecurity Analyst Intern',
      company: 'SecureNet Europe',
      location: 'Amsterdam, Netherlands',
      type: 'Internship',
      description:
          '6-month internship focusing on threat detection and incident response.',
      imageUrl:
          'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400&q=80',
    ),
    Opportunity(
      id: 'opp-3',
      title: 'Healthcare Data Scientist',
      company: 'MedAI Solutions',
      location: 'Dubai, UAE',
      type: 'Full-time',
      description:
          'Apply ML models to improve patient outcomes in regional hospitals.',
      imageUrl:
          'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=400&q=80',
      isSaved: true,
    ),
    Opportunity(
      id: 'opp-4',
      title: 'Product Manager - AI Products',
      company: 'InnovateLab',
      location: 'Remote (EU)',
      type: 'Full-time',
      description:
          'Lead product strategy for AI-powered SaaS tools in the B2B space.',
      imageUrl:
          'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=400&q=80',
    ),
  ];

  static final certificates = <Certificate>[
    Certificate(
      id: 'cert-1',
      title: 'AI Fundamentals Certificate',
      programName: 'AI for Managers',
      issuedDate: DateTime(2025, 11, 15),
      credentialId: 'PRX-AI-MGR-2025-001',
    ),
  ];

  static const mockUser = UserModel(
    id: 'user-1',
    name: 'Alex Morgan',
    email: 'alex.morgan@email.com',
    avatarUrl:
        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&q=80',
    enrolledProgramIds: ['prog-1', 'prog-4'],
    certificateIds: ['cert-1'],
    savedOpportunityIds: ['opp-1', 'opp-3'],
    learningStreak: 12,
    totalXp: 2450,
  );

  /// Mock AI responses keyed by topic keywords.
  static String getAiResponse(String question) {
    final q = question.toLowerCase();

    if (q.contains('program') || q.contains('take') || q.contains('which')) {
      return 'Based on your profile, I recommend starting with **AI for Managers** if you are in a leadership role, or **AI for Developers** if you have a technical background.\n\n'
          'For healthcare professionals, **AI for Healthcare** is tailored to your domain. '
          'If security interests you, the **Cybersecurity Internship** offers hands-on experience with real projects.\n\n'
          'Would you like me to compare any two programs in detail?';
    }

    if (q.contains('certif')) {
      return 'Praktix offers industry-recognized certificates for all programs:\n\n'
          '• **AI for Managers** — AI Leadership Certificate\n'
          '• **AI for Developers** — Applied AI Engineering Certificate\n'
          '• **AI for Healthcare** — Healthcare AI Specialist Certificate\n'
          '• **Cybersecurity Internship** — Cybersecurity Professional Certificate\n\n'
          'All certificates include a verifiable credential ID that employers can validate. '
          'Which field are you most interested in?';
    }

    if (q.contains('ai') || q.contains('move') || q.contains('career')) {
      return 'Moving into AI is a great career decision! Here is a recommended path:\n\n'
          '1. **Assess your background** — Technical or business-focused?\n'
          '2. **Start with fundamentals** — AI for Managers or AI for Developers\n'
          '3. **Build projects** — Our programs include portfolio-ready work\n'
          '4. **Get certified** — Earn credentials employers recognize\n'
          '5. **Apply to opportunities** — We have 2000+ successful placements\n\n'
          'I suggest booking a mentorship session with James Okafor for personalized guidance!';
    }

    return 'That is a great question! As your AI Career Advisor, I can help you with:\n\n'
        '• Choosing the right program for your goals\n'
        '• Understanding certification options\n'
        '• Planning your career transition into AI\n'
        '• Finding mentorship and job opportunities\n\n'
        'Try asking: "Which program should I take?" or "How can I move into AI?"';
  }
}
