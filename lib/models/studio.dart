class Studio {
  final int id;
  final String name;
  final String location;
  final String people;
  final String price;
  final String duration;
  final String category;
  final String cooling;
  final String availableTime;
  final String matchPercentage;
  final String hostName;
  final String hostInitials;
  final String description;
  final List<String> facilities;
  final String imageUrl;

  const Studio({
    required this.id,
    required this.name,
    required this.location,
    required this.people,
    required this.price,
    required this.duration,
    required this.category,
    this.cooling = 'AC',
    this.availableTime = 'Available at 11:00',
    this.matchPercentage = '98% MATCH',
    this.hostName = 'Nadia Studio',
    this.hostInitials = 'NS',
    this.description =
        'A sunlit creative studio with high ceilings, movable backdrops, and everything you need for your next shoot.',
    this.facilities = const [
      'Wi-Fi',
      '3 Backdrops',
      'Lighting',
      'Changing room',
    ],
    required this.imageUrl,
  });
}

// Data Dummy Studio MyStudio
final List<Studio> dummyStudios = [
  const Studio(
    id: 1,
    name: 'Atelier Kecil',
    location: 'Kemang, Jakarta',
    people: '8 people',
    price: 'Rp90k',
    duration: ' / 2 hr',
    category: 'Natural light',
    cooling: 'AC',
    availableTime: 'Available at 11:00',
    matchPercentage: '98% MATCH',
    hostName: 'Nadia Studio',
    hostInitials: 'NS',
    description:
        'A sunlit creative studio with high ceilings, movable backdrops, and everything you need for your next shoot.',
    facilities: ['Wi-Fi', '3 Backdrops', 'Lighting', 'Changing room'],
    imageUrl:
        'https://images.unsplash.com/photo-1586232702178-f044c5f4d4b7?auto=format&fit=crop&w=1000&q=85',
  ),
  const Studio(
    id: 2,
    name: 'Sora Space',
    location: 'Cilandak, Jakarta',
    people: '12 people',
    price: 'Rp120k',
    duration: ' / 2 hr',
    category: 'Color backdrop',
    cooling: 'AC',
    availableTime: 'Available at 11:00',
    matchPercentage: '91% MATCH',
    hostName: 'Sora Creative',
    hostInitials: 'SC',
    description:
        'Modern studio space equipped with colorful seamless backdrops and professional softbox lighting systems.',
    facilities: ['Wi-Fi', 'Cyclorama', 'Softbox', 'Changing room', 'AC'],
    imageUrl:
        'https://images.unsplash.com/photo-1647427854253-b92bb40c9330?auto=format&fit=crop&w=1000&q=85',
  ),
  const Studio(
    id: 3,
    name: 'Rumah Rona',
    location: 'Menteng, Jakarta',
    people: '10 people',
    price: 'Rp150k',
    duration: ' / 2 hr',
    category: 'Full equipment',
    cooling: 'AC',
    availableTime: 'Available at 11:00',
    matchPercentage: '88% MATCH',
    hostName: 'Rona Art Space',
    hostInitials: 'RA',
    description:
        'Spacious vintage aesthetic studio with natural ambient lighting, sound system, and comfortable lounge area.',
    facilities: ['Wi-Fi', 'Pro Lighting', 'Sound System', 'Lounge', 'AC'],
    imageUrl:
        'https://images.unsplash.com/photo-1527011046414-4781f1f94f8c?auto=format&fit=crop&w=1000&q=85',
  ),
];

