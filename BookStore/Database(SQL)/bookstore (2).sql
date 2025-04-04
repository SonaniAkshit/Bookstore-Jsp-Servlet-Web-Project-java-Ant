-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 04, 2025 at 06:08 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstore`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_logout` datetime DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `email`, `contact`, `gender`, `password`, `role`, `last_login`, `last_logout`, `status`) VALUES
(2, 'hardik mekhiya', 'hardik@gmail.com', '9879997898', 'Male', 'hardik', 'admin', '2025-04-04 08:18:26', '2025-04-04 01:52:45', 'Active'),
(3, 'nitesh desai', 'nitesh@gmail.com', '8263514267', 'Male', 'nitesh', 'admin', NULL, NULL, 'Inactive');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL,
  `description` text NOT NULL,
  `publisher_email` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `image`, `name`, `author`, `price`, `category`, `stock`, `description`, `publisher_email`, `created_at`) VALUES
(9, 'images/books/s-l1600.webp', 'Sci Fi Adventure, Escape From Desolation', 'Robert F. Glahe', 140.49, 'Action', 10, 'Book One: Inclusion, Signed', 'akshit@gmail.com', '2025-04-02 08:35:26'),
(10, 'images/books/211004050.jpg', 'Splinter Effect', 'Andrew Ludington', 89.25, 'Action', 20, 'In this action-packed debut.', 'akshit@gmail.com', '2025-04-02 08:40:19'),
(11, 'images/books/the-hidden-hindu-3-original-imagu7sacwcydkas.webp', 'The Hidden Hindu', 'Gupta Akshat', 34.90, 'Action', 20, 'Akshat Gupta is a national bestselling author, a TEDx speaker and an excelling screenwriter and dialogue writer in the Indian film industry.', 'akshit@gmail.com', '2025-04-02 08:47:55'),
(12, 'images/books/the-scarlet-letter-original-imagbyzczjmjx5eh.webp', 'The Scarlet Letter', 'Hawthorne Nathaniel', 200.00, 'Action', 20, 'The Scarlet Letter  (English, Paperback, Hawthorne Nathaniel)', 'akshit@gmail.com', '2025-04-02 08:55:07'),
(13, 'images/books/the-secret-of-the-nagas-shiva-trilogy-book-2-original-imah7h2ysnqes5ah.webp', 'The Secret Of The Nagas', 'Tripathi Amish', 310.00, 'Action', 30, 'The Secret Of The Nagas (Shiva Trilogy Book 2)  (English, Paperback, Tripathi Amish)', 'akshit@gmail.com', '2025-04-02 08:57:41'),
(14, 'images/books/81Budsu1XBL._AC_UY327_FMwebp_QL65_.webp', 'HARRY POTTER AND THE ORDER OF THE PHOENIX - 5', 'J.K. Rowling', 550.00, 'Fantasy', 40, 'Dark times have come to Hogwarts. After the Dementors\' attack on his cousin Dudley, Harry Potter knows that Voldemort will stop at nothing to find him.', 'akshit@gmail.com', '2025-04-02 09:00:43'),
(15, 'images/books/81NPFB3iTkL._SY466_.jpg', 'Harry Potter and the Order of Phoenix', 'J.K. Rowling', 450.00, 'Fantasy', 40, 'Let the magic of J.K. Rowling\'s classic Harry Potter series transport you to Hogwarts School of Witchcraft and Wizardry.', 'akshit@gmail.com', '2025-04-02 09:01:59'),
(16, 'images/books/71jKeGU9nKL._SY466_.jpg', 'The Hobbit', 'J.R.R. Tolkien', 312.00, 'Fantasy', 23, 'The Hobbit (Film tie-in edition)', 'akshit@gmail.com', '2025-04-02 09:07:13'),
(17, 'images/books/81U6F6IaPzL._SY466_.jpg', 'Plop: A Horror Short Story', 'Samuel Small', 200.00, 'Horror', 50, 'Plop: A Horror Short Story (Samuel Small Horror Book 1) Kindle Edition', 'sunny@gmail.com', '2025-04-02 14:53:22'),
(18, 'images/books/91TBcPLZqJL._SY466_.jpg', 'The Wind on the Haunted Hill', ' Ruskin Bond', 150.60, 'Horror', 12, 'The Wind on the Haunted Hill Paperback – 1 January 2018\r\nby Ruskin Bond (Author)', 'sunny@gmail.com', '2025-04-02 14:54:43'),
(19, 'images/books/51apiITyKaL._SY445_SX342_.jpg', 'Right Behind You', 'Neil D\'Silva', 500.50, 'Horror', 12, 'Right Behind You | Horror Books for Teens and Adults | A Collection of Horror and Paranormal Short Stories', 'sunny@gmail.com', '2025-04-02 14:56:25'),
(20, 'images/books/51cDJwaroAL._SY445_SX342_.jpg', 'The Haunting of Delhi City', 'Jatin Bhasin', 400.30, 'Horror', 20, 'The Haunting of Delhi City : Tales of the Supernatural', 'sunny@gmail.com', '2025-04-02 14:57:49'),
(21, 'images/books/71U8PEXHcOL._SY466_.jpg', 'Playthings', 'Neil D\'Silva', 219.23, 'Horror', 50, 'Playthings: Toys Of Terror', 'sunny@gmail.com', '2025-04-02 14:59:53'),
(22, 'images/books/610PYeHzOuL._SY466_.jpg', 'Dracula', 'Bram Stoker', 193.24, 'Gothic', 45, 'Dracula Paperback – 1 January 2013\r\nby Bram Stoker (Author)', 'sunny@gmail.com', '2025-04-02 15:17:14'),
(23, 'images/books/71umXQdz6hL._SY466_.jpg', 'The Red Hollow', 'Natalie Marlow', 515.45, 'Gothic', 23, 'The Red Hollow (William Garrett Novels)', 'sunny@gmail.com', '2025-04-02 15:19:02'),
(24, 'images/books/41UYhd2WSjL._SY445_SX342_.jpg', 'Seven Gothic', 'Isak Dinesen', 200.30, 'Gothic', 23, 'Seven Gothic Tales Paperback – 31 October 2002\r\nby Isak Dinesen (Author)', 'sunny@gmail.com', '2025-04-02 15:25:04'),
(25, 'images/books/71EvX+rGkhL._SY466_.jpg', 'Gothic Tales', 'Elizabeth Gaskell', 360.30, 'Gothic', 60, 'Gothic Tales Paperback – 14 August 2000\r\nby Elizabeth Gaskell (Author)', 'sunny@gmail.com', '2025-04-02 15:27:14'),
(26, 'images/books/41b8CtayNnL._SX342_SY445_.jpg', 'Frankenstein', 'Mary Shelley', 500.00, 'Gothic', 20, 'Frankenstein | Gothic Horror & Mystery Classic | Unabridged English Novel', 'sunny@gmail.com', '2025-04-02 15:28:40'),
(28, 'images/books/71SaAoEqWiL._SY425_.jpg', 'A Changing Light', 'Edith Maxwell', 1200.00, 'Mystery', 80, 'A Changing Light: 7 (Quaker Midwife Mysteries) ', 'jay@gmail.com', '2025-04-02 15:33:39'),
(29, 'images/books/41GuDX+jKsL._SY445_SX342_.jpg', 'And Then There Were None', 'Agatha Christie', 3000.00, 'Mystery', 67, 'And Then There Were None: The World’s Favourite Agatha Christie Book', 'jay@gmail.com', '2025-04-02 15:35:20'),
(30, 'images/books/41Vg30m+9jL._SY445_SX342_.jpg', 'The Murder at Sissingham Hall', 'Clara Benson', 2100.00, 'Mystery', 30, 'The Murder at Sissingham Hall (An Angela Marchmont Mystery Book 1) Kindle Edition', 'jay@gmail.com', '2025-04-02 15:37:05'),
(31, 'images/books/81+ceFx9BcL._SY466_.jpg', 'Never Lie', 'The Housemaid Freida McFadden', 3200.00, 'Mystery', 23, 'Never Lie : A Totally Gripping Thriller with Mind-bending Twists', 'jay@gmail.com', '2025-04-02 15:39:30'),
(32, 'images/books/61tjQbGegnL._SY466_.jpg', 'The Mysteries of Udolpho', 'Ann Ward Radcliffe', 2100.00, 'Mystery', 56, 'The Mysteries of Udolpho: A Gothic Masterpiece Kindle Edition', 'jay@gmail.com', '2025-04-02 15:41:00'),
(33, 'images/books/41mmACzEktL._SY445_SX342_.jpg', 'An Historical Mystery', 'Honoré de Balzac', 340.00, 'Historical', 45, 'An Historical Mystery Kindle Edition\r\nby Honoré de Balzac (Author), Katharine Prescott Wormeley (Translator)', 'jay@gmail.com', '2025-04-02 15:44:16'),
(34, 'images/books/81ZZBIeTjqL._SY425_.jpg', 'History Mystery', 'SHARMA NATASHA', 800.00, 'Historical', 30, 'History Mystery: Tughlaq And The Stolen', 'jay@gmail.com', '2025-04-02 15:46:56'),
(35, 'images/books/81u62U5GuQL._SY466_.jpg', 'Bilingual Book English/Spanish', 'Ariel Sanders', 788.00, 'Historical', 67, 'Bilingual Book English/Spanish for Intermediate Learners: Syndicate - A Thrilling Crime Mystery (The Dark Series) (Spanish Edition)', 'jay@gmail.com', '2025-04-02 15:48:43'),
(36, 'images/books/71XQfLqWG2L._SY466_.jpg', 'Ashva', 'Krishna Deo Mistry', 430.00, 'Science', 23, 'Ashva Kindle Edition\r\nby Krishna Deo Mistry (Author) ', 'jay@gmail.com', '2025-04-02 16:20:00'),
(37, 'images/books/81EIFBObjoL._SY466_.jpg', 'Time Trap', 'Micah Caida', 280.00, 'Science', 50, 'Time Trap: Red Moon science fiction, time travel trilogy book 1 (Red Moon Trilogy)', 'jay@gmail.com', '2025-04-02 16:21:46'),
(38, 'images/books/51CF4m7T8fL._SY445_SX342_.jpg', 'Relativity', 'Albert Einstein', 500.00, 'Science', 30, 'Relativity: The Special And The General Theory by Albert Einstein | Concepts of Physics, Relativity, General Relativity & Quantum Mechanics | Conceptual Physics, University Physics & Calculus Core', 'jay@gmail.com', '2025-04-02 16:23:40'),
(39, 'images/books/81DAK5xNjQL._SY425_.jpg', 'Black Holes', 'Stephen Hawking', 1500.00, 'Science', 60, 'Black Holes (L) : The Reith Lectures', 'jay@gmail.com', '2025-04-02 16:25:43'),
(40, 'images/books/61-ovgbVVwL._SX342_SY445_.jpg', 'My Inventions', 'Nikola Tesla', 1500.00, 'Science', 60, 'My Inventions, Autobiography of Nikola Tesla', 'anis@gmail.com', '2025-04-02 16:38:07'),
(41, 'images/books/41KiyP6vx1L._SY445_SX342_.jpg', 'Science and Magic', 'Aditya Upadhaya', 450.00, 'Science', 23, 'Science and Magic - The Search Begins', 'anis@gmail.com', '2025-04-02 16:39:51'),
(42, 'images/books/51vRNIgDcfL._SY445_SX342_.jpg', 'Orbital', 'Samantha Harvey', 230.00, 'Science', 23, 'Orbital: Winner of the Booker Prize 2024', 'anis@gmail.com', '2025-04-02 16:41:16'),
(43, 'images/books/61SwQvI0aKL._SY466_.jpg', 'Reset', 'Janet Elizabeth Henderson', 3400.00, 'Romantic thriller', 25, 'Reset: Romantic Thriller: 7 (Benson Security)', 'anis@gmail.com', '2025-04-02 16:55:05'),
(44, 'images/books/71il8051uQL._SY466_.jpg', 'The Girl Who Wants', 'Amy Vansant', 1200.00, 'Romantic thriller', 80, 'The Girl Who Wants: An addictive romantic thriller packed with twists and dangerous family secrets.', 'anis@gmail.com', '2025-04-02 16:59:52'),
(45, 'images/books/41bXuOUzOIL._SY445_SX342_.jpg', 'Lead from the Front', ' Sudeep Krishna, Purav Gandhi', 566.00, 'Action', 34, 'Lead from the Front : Inspiring military stories of courage, leadership and resilience', 'akshit@gmail.com', '2025-04-04 01:20:04'),
(46, 'images/books/519FnsjuzpL._SY445_SX342_.jpg', 'The Book That Wouldn’t Burn', ' Mark Lawrence', 1200.00, 'Action', 45, 'The Book That Wouldn’t Burn: Book 1 (The Library Trilogy)', 'akshit@gmail.com', '2025-04-04 01:21:22'),
(47, 'images/books/81T+O7ResjL._SY466_.jpg', 'The Gollancz', ' Tarun K. Saint', 4000.00, 'Science', 45, 'The Gollancz Book of South Asian Science Fiction Volume 2', 'akshit@gmail.com', '2025-04-04 01:23:35'),
(48, 'images/books/7129AhYq1GL._SY466_.jpg', 'ACTION', 'J Krishnamurti ', 344.00, 'Action', 23, 'ACTION: THE TEACHINGS OF J. KRISHNAMURTI', 'akshit@gmail.com', '2025-04-04 01:28:03'),
(49, 'images/books/81Aoq-Asg8L._SY385_.jpg', 'Nectar on the Seven Hills', ' Prabhu Ram', 5000.00, 'Fantasy', 50, 'Nectar on the Seven Hills - The Pure Seed - An Epic Fusion of Indian Mythology | Fantasy Adventure', 'akshit@gmail.com', '2025-04-04 01:31:52'),
(50, 'images/books/91g4YHEkGkL._SY342_.jpg', 'Ghosts of The Silent Hills', ' Anita Krishan', 5500.00, 'Horror', 50, 'Ghosts of The Silent Hills: Stories based on true hauntings', 'anis@gmail.com', '2025-04-04 08:28:47'),
(51, 'images/books/81b1PP4RK1L._SY466_.jpg', 'That Night', ' UPADHYAY NIDHI', 2000.00, 'Horror', 80, 'That Night: Four Friends, Twenty Years, One Haunting Secret [Paperback] Nidhi Upadhyay', 'anis@gmail.com', '2025-04-04 08:30:53'),
(52, 'images/books/41MsKF3GfEL._SY445_SX342_.jpg', 'Hidden Pictures', ' Jason Rekulak', 5000.00, 'Horror', 56, 'Hidden Pictures Paperback – 6 June 2023\r\nby Jason Rekulak (Author), Will Staehle (Illustrator), Doogie Horner (Illustrator)', 'anis@gmail.com', '2025-04-04 08:32:09'),
(53, 'images/books/81X7pb2R5iL._SY342_.jpg', 'Dracula (Deluxe Hardbound Edition)', ' Bram Stoker', 34.00, 'Gothic', 100, 'Dracula (Deluxe Hardbound Edition): A Timeless Novel of Gothic Fiction Vampire Novel Horror Classic Transylvania Victorian Era Supernatural Creatures ... and Bloodlust Perfect for Horror', 'anis@gmail.com', '2025-04-04 08:34:32'),
(54, 'images/books/7182rdXnV1L._SY466_.jpg', 'Young Gothic', ' M.A. Bennett', 300.00, 'Gothic', 29, 'Young Gothic Paperback\r\nby M.A. Bennett (Author)\r\n', 'anis@gmail.com', '2025-04-04 08:36:40'),
(55, 'images/books/91JWQ95s5NL._SY466_.jpg', 'MEXICAN GOTHIC', ' Silvia Moreno-Garcia', 8000.00, 'Gothic', 30, 'MEXICAN GOTHIC Paperback\r\nby Silvia Moreno-Garcia (Author)', 'anis@gmail.com', '2025-04-04 08:37:57'),
(56, 'images/books/61cVI3aJp4L._SY466_.jpg', 'THE UNEXPECTED LEADER', ' Joel Sadhanand', 3090.00, 'Mystery', 50, 'THE UNEXPECTED LEADER Paperback – 9 December 2020\r\nby Joel Sadhanand (Author)', 'anis@gmail.com', '2025-04-04 08:40:16'),
(57, 'images/books/71YMKj-3PiL._SY466_.jpg', 'Casino Royale', ' Ian Fleming', 4000.00, 'Mystery', 40, 'Casino Royale: A James Bond Novel | A Spy Thriller', 'anis@gmail.com', '2025-04-04 08:42:11'),
(58, 'images/books/51SGfpyA6hL._SY445_SX342_.jpg', 'The Secret Key', 'Lena Jones', 5000.00, 'Mystery', 50, 'The Secret Key: Agatha Oddly (1)', 'anis@gmail.com', '2025-04-04 08:43:32'),
(59, 'images/books/71NDa85qT7L._SY425_.jpg', 'Shivaji', 'Ranjit Desai ', 1150.00, 'Historical', 80, 'Shivaji: The Great Maratha Paperback\r\nby Ranjit Desai (Author), Vikrant Pande (Translator)', 'sunny@gmail.com', '2025-04-04 08:46:40'),
(60, 'images/books/419Lf6xEQKL._SY445_SX342_.jpg', 'Too Good to Be True', ' Prajakta Koli', 900.00, 'Romantic thriller', 80, 'Too Good to Be True : A smart, funny will-they-won’t-they romance by mostlysane', 'sunny@gmail.com', '2025-04-04 08:48:58'),
(61, 'images/books/4120crLpHiL._SY445_SX342_.jpg', 'The Match', ' Sarah Adams', 2100.00, 'Romantic thriller', 90, 'The Match ǀ A feel good Romantic Comedy by a New York Times Bestselling author ǀ TikTok made me buy it!', 'sunny@gmail.com', '2025-04-04 08:51:01'),
(62, 'images/books/51NLZxGANRL._SY445_SX342_.jpg', 'It Ain\'t Over...', ' Robert M. Kerns', 830.89, 'Space opera', 90, 'It Ain\'t Over...: An Epic Space Opera Adventure (Cole & Srexx Book 1)', 'sunny@gmail.com', '2025-04-04 08:54:14'),
(63, 'images/books/81eANN9fYjL._SY425_.jpg', 'Headless in Space', ' Lars Greenleaf', 980.80, 'Space opera', 89, 'Headless in Space: A Space Opera Novel (Everyday Space Heroes Book 1)', 'sunny@gmail.com', '2025-04-04 08:56:35'),
(64, 'images/books/8184AynDPiL._SY466_.jpg', ' Spencer Ellsworth', ' Spencer Ellsworth (Author), Andrew Neil Gray (Author), J.S. Herbison (Author), Dave Hutchinson', 836.00, 'Space opera', 30, 'Tor.com Publishing\'s Summer of Space Opera Sampler Kindle Edition\r\nby Spencer Ellsworth (Author), Andrew Neil Gray (Author), J.S. Herbison (Author), Dave Hutchinson (Author)', 'sunny@gmail.com', '2025-04-04 08:58:30'),
(65, 'images/books/51t-uiSjF1L._SY445_SX342_.jpg', 'Space Opera', ' Catherynne M. Valente', 900.67, 'Space opera', 78, 'Space Opera: HUGO AWARD FINALIST FOR BEST NOVEL 2019', 'sunny@gmail.com', '2025-04-04 09:00:33'),
(66, 'images/books/71IbfWECC0L._SY466_.jpg', 'Krishna: The Man & His Philosophy', ' Osho', 1100.00, 'Philosophy', 80, 'Krishna: The Man & His Philosophy PaperbackEdition\r\nby Osho (Author)', 'sunny@gmail.com', '2025-04-04 09:04:36'),
(67, 'images/books/41vGTDTsdTL._SY445_SX342_.jpg', 'Physics & Philosophy', ' W Heisenberg', 900.56, 'Philosophy', 78, 'Physics & Philosophy Paperback\r\nby W Heisenberg (Author)', 'sunny@gmail.com', '2025-04-04 09:06:11'),
(68, 'images/books/71fTsm3pM5L._SY342_.jpg', 'As A Man Thinketh', ' James Allen', 5100.00, 'Philosophy', 80, 'As A Man Thinketh by James Allen [Premium Paperback] |Philosophy & Human Psychology Book for Personal Growth | Self Help to Think Better Thoughts | Self Improvement Book | The Art Of Contrary Thinking', 'sunny@gmail.com', '2025-04-04 09:08:05'),
(69, 'images/books/51MB4Tc-cFL._SY466_.jpg', 'The Book of life', ' J. Krishnamurti ', 900.78, 'Philosophy', 89, 'The Book of life Paperback\r\nby J. Krishnamurti (Author)', 'sunny@gmail.com', '2025-04-04 09:09:37'),
(70, 'images/books/81SJj7jF6QL._SY425_.jpg', 'Soft Science', ' Franny Choi', 1200.00, 'Soft science', 90, 'Soft Science Paperback\r\nby Franny Choi (Author)', 'akshit@gmail.com', '2025-04-04 09:13:42'),
(71, 'images/books/81RWCtFmVgL._SY342_.jpg', '365 Science Experiments', ' Om Books Editorial Team', 730.78, 'Soft science', 30, 'Encyclopedia : 365 Science Experiments (365 Series)', 'akshit@gmail.com', '2025-04-04 09:15:47'),
(72, 'images/books/51Jwr7dxY1S._SY385_.jpg', 'NCERT Science (PCB) for Class 11 Books Set 11', ' YOUR SCHOOL POINT', 1200.00, 'Soft science', 80, 'NCERT Science (PCB) for Class 11 Books Set 11 (English Medium) (5 Books) Hardcover', 'akshit@gmail.com', '2025-04-04 09:23:00'),
(73, 'images/books/61mpcp01mEL._SY385_.jpg', 'Planet Coloring Book', ' Harper Hall ', 100.90, 'Soft science', 80, 'Planet Coloring Book Paperback\r\nby Harper Hall (Author)\r\n', 'akshit@gmail.com', '2025-04-04 09:25:09'),
(74, 'images/books/51OpvbdQQ3L._SY445_SX342_.jpg', 'The Family Upstairs', 'Lisa Jewell', 1200.67, 'Thriller', 90, 'The Family Upstairs Paperback\r\nby Lisa Jewell (Author)', 'akshit@gmail.com', '2025-04-04 09:28:33'),
(75, 'images/books/81keZ6LpNWL._SY466_.jpg', 'The Housemaid', ' Freida McFadden ', 900.34, 'Thriller', 90, 'The Housemaid : An addictive psychological thriller with mind-bending twists', 'akshit@gmail.com', '2025-04-04 09:30:02'),
(76, 'images/books/71sa1DXwbfL._SY466_.jpg', 'The Boyfriend', ' Freida McFadden ', 230.60, 'Thriller', 90, 'The Boyfriend: The Riveting New Psychological Thriller from BESTSELLING author of THE HOUSEMAID', 'akshit@gmail.com', '2025-04-04 09:31:18'),
(77, 'images/books/810fMTMuZML._SY425_.jpg', 'Girl, Alone', ' Blake Pierce', 90.00, 'Thriller', 30, 'Girl, Alone (An Ella Dark FBI Suspense Thriller—Book 1)', 'akshit@gmail.com', '2025-04-04 09:32:28');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `bookname` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `publisher_email` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL CHECK (`quantity` > 0),
  `user_email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `bookname`, `author`, `publisher_email`, `price`, `image`, `quantity`, `user_email`) VALUES
(18, 'The Wind on the Haunted Hill', ' Ruskin Bond', 'sunny@gmail.com', 150.60, 'images/books/91TBcPLZqJL._SY466_.jpg', 100, 'abc@gmail.com'),
(20, 'The Haunting of Delhi City', 'Jatin Bhasin', 'sunny@gmail.com', 400.30, 'images/books/51cDJwaroAL._SY445_SX342_.jpg', 100, 'abc@gmail.com'),
(21, 'Playthings', 'Neil D\'Silva', 'sunny@gmail.com', 219.23, 'images/books/71U8PEXHcOL._SY466_.jpg', 100, 'abc@gmail.com'),
(24, 'Seven Gothic', 'Isak Dinesen', 'sunny@gmail.com', 200.30, 'images/books/41UYhd2WSjL._SY445_SX342_.jpg', 101, 'abc@gmail.com'),
(28, 'A Changing Light', 'Edith Maxwell', 'jay@gmail.com', 1200.00, 'images/books/71SaAoEqWiL._SY425_.jpg', 100, 'hemal@gmail.com'),
(29, 'And Then There Were None', 'Agatha Christie', 'jay@gmail.com', 3000.00, 'images/books/41GuDX+jKsL._SY445_SX342_.jpg', 100, 'abc@gmail.com'),
(30, 'The Murder at Sissingham Hall', 'Clara Benson', 'jay@gmail.com', 2100.00, 'images/books/41Vg30m+9jL._SY445_SX342_.jpg', 100, 'hemal@gmail.com'),
(31, 'Never Lie', 'The Housemaid Freida McFadden', 'jay@gmail.com', 3200.00, 'images/books/81+ceFx9BcL._SY466_.jpg', 100, 'hemal@gmail.com'),
(34, 'History Mystery', 'SHARMA NATASHA', 'jay@gmail.com', 800.00, 'images/books/81ZZBIeTjqL._SY425_.jpg', 100, 'hemal@gmail.com'),
(47, 'The Gollancz', ' Tarun K. Saint', 'akshit@gmail.com', 4000.00, 'images/books/81T+O7ResjL._SY466_.jpg', 100, 'hemal@gmail.com'),
(49, 'Nectar on the Seven Hills', ' Prabhu Ram', 'akshit@gmail.com', 5000.00, 'images/books/81Aoq-Asg8L._SY385_.jpg', 100, 'hemal@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `description`, `created_at`) VALUES
(8, 'Action', 'Action fiction', '2025-04-02 02:52:36'),
(9, 'Fantasy', 'Fantasy fiction', '2025-04-02 02:53:09'),
(10, 'Horror', 'Horror fiction', '2025-04-02 02:53:44'),
(11, 'Gothic', 'Gothic fiction', '2025-04-02 02:54:04'),
(12, 'Mystery', 'Mystery fiction', '2025-04-02 02:54:41'),
(13, 'Historical', 'Historical mystery', '2025-04-02 02:55:15'),
(14, 'Science', 'Science fiction', '2025-04-02 02:56:23'),
(15, 'Romantic thriller', 'Romantic thriller', '2025-04-02 02:56:47'),
(16, 'Space opera', 'Space opera', '2025-04-02 02:57:06'),
(18, 'Soft science', 'Soft science fiction', '2025-04-02 02:57:35'),
(19, 'Thriller', 'Thriller fiction', '2025-04-02 02:58:12'),
(20, 'Philosophy', 'Philosophy', '2025-04-02 02:58:40');

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

CREATE TABLE `publisher` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_logout` datetime DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `publisher`
--

INSERT INTO `publisher` (`id`, `name`, `email`, `contact`, `gender`, `password`, `role`, `last_login`, `last_logout`, `status`) VALUES
(22, 'anis mansuri', 'anis@gmail.com', '6745728493', 'Male', 'anis', 'publisher', '2025-04-04 09:11:27', '2025-04-04 09:11:30', 'Inactive'),
(23, 'akshit sonani', 'akshit@gmail.com', '7778813428', 'Male', 'akshit', 'publisher', '2025-04-04 09:11:43', '2025-04-04 09:34:26', 'Inactive'),
(24, 'jay heruwala', 'jay@gmail.com', '868768768', 'Male', 'jay', 'publisher', '2025-04-04 09:11:33', '2025-04-04 09:11:38', 'Inactive'),
(25, 'sunny thakor', 'sunny@gmail.com', '6745728493', 'Male', 'sunny', 'publisher', '2025-04-04 09:11:18', '2025-04-04 09:11:21', 'Inactive');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_logout` datetime DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `contact`, `gender`, `password`, `role`, `last_login`, `last_logout`, `status`) VALUES
(10, 'hemal rathod', 'hemal@gmail.com', 'hemal@gmail.com', 'Male', 'hemal', 'User', '2025-04-04 08:18:44', '2025-04-04 08:18:46', 'Inactive'),
(11, 'abc', 'abc@gmail.com', '23', 'Male', 'abc', 'User', '2025-04-04 00:51:03', '2025-04-04 01:08:23', 'Inactive'),
(12, 'manish desai', 'manish@gmail.com', '9876543526', 'Male', 'manish', 'User', NULL, NULL, 'Inactive'),
(13, 'ashwin desai', 'ashwin@gmail.com', '9853624315', 'Male', 'ashwin', 'User', NULL, NULL, 'Inactive'),
(14, 'jignesh desai', 'jignesh@gmail.com', '9824516278', 'Male', 'jignesh', 'User', NULL, NULL, 'Inactive'),
(15, 'praveen prajapati', 'praveen@gmail.com', '9825614239', 'Male', 'praveen', 'User', NULL, NULL, 'Inactive');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_email` (`user_email`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `publisher`
--
ALTER TABLE `publisher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
