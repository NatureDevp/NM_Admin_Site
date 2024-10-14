import '../models/md_user.dart';

List<User> ALL_USERS = [
  User(
    id: '120',
    name: 'John Doe',
    email: 'johndoe@gmail.com',
    password: 'password123',
    token: 'active-token',
    dateCreated: 'June 23, 2024, 12:00 PM',
    lastUpdated: 'June 24, 2024, 02:00 PM',
  ),
  User(
    id: '121',
    name: 'Jane Smith',
    email: 'smith@gmail.com',
    password: 'password123',
    token: 'active-token',
    dateCreated: 'June 23, 2024, 11:00 AM',
    lastUpdated: 'June 24, 2024, 02:00 PM',
  ),
  User(
    id: '122',
    name: 'Bob Brown',
    email: 'bobBrown@gmail.com',
    password: 'password123',
    token: 'active-token',
    dateCreated: 'June 14, 2024, 09:30 AM',
    lastUpdated: 'June 15, 2024, 05:30 PM',
  ),
  User(
    id: '123',
    name: 'Alice Lee',
    email: 'alice@gmail.com',
    password: 'password123',
    token: 'active-token',
    dateCreated: 'June 12, 2024, 08:45 AM',
    lastUpdated: 'June 14, 2024, 10:30 AM',
  ),
  User(
    id: '124',
    name: 'Tom Johnson',
    email: 'tom@gmail.com',
    password: 'password123',
    token: '',
    dateCreated: 'June 10, 2024, 07:20 AM',
    lastUpdated: 'June 11, 2024, 03:00 PM',
  ),
];

UserColumn USER_COLUMNS = UserColumn(
  id: 'User ID',
  name: 'Name',
  email: 'Email',
  dateCreated: 'Date Created',
  lastUpdated: 'Last Updated',
);
