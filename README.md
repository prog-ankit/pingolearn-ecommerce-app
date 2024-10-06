<h1>Pingolearn E-commerce App</h1>

<h2>Overview</h2>
<p>The <strong>Pingolearn E-commerce App</strong> is a Flutter-based application that provides users with a seamless shopping experience. The app integrates various Firebase services, state management solutions, and navigation techniques to create a modern and responsive e-commerce platform.</p>

<h2>Features</h2>
<ul>
    <li><strong>User Authentication:</strong> Secure login and signup functionality with validation to ensure user credentials are handled properly.</li>
    <li><strong>Product Listing:</strong> Home page displays a list of products fetched from an API.</li>
    <li><strong>State Management:</strong> Utilizes Flutter's Provider package for effective state management throughout the app.</li>
    <li><strong>Navigation:</strong> Implemented using the Get package for easy and efficient navigation between screens.</li>
    <li><strong>Data Storage:</strong> Firestore is employed for storing user and product data securely.</li>
    <li><strong>Remote Configuration:</strong> Firebase Remote Config is used to manage app configurations dynamically without needing to deploy a new version.</li>
</ul>

<h2>Technologies Used</h2>
<ul>
    <li><strong>Flutter:</strong> The framework used for building the UI.</li>
    <li><strong>Provider:</strong> For state management, ensuring a reactive interface.</li>
    <li><strong>Get:</strong> For navigation, making transitions between screens simple and efficient.</li>
    <li><strong>Firestore:</strong> Used for data storage to keep user and product information.</li>
    <li><strong>Firebase Authentication:</strong> For secure user authentication.</li>
    <li><strong>Firebase Remote Config:</strong> To control and manage app settings remotely.</li>
    <li><strong>HTTP Package:</strong> To fetch data from an external API for product listings.</li>
</ul>

<h2>Installation</h2>
<p>To run the app locally, follow these steps:</p>
<ol>
    <li>Clone the repository:</li>
    <pre><code>git clone https://github.com/prog-ankit/pingolearn-ecommerce-app.git</code></pre>
    <li>Navigate to the project directory:</li>
    <pre><code>cd pingolearn_ecommerce_app</code></pre>
    <li>Install the dependencies:</li>
    <pre><code>flutter pub get</code></pre>
    <li>Configure Firebase for your project by following the official Firebase setup guide and ensure to update the <code>google-services.json</code> (for Android) and <code>GoogleService-Info.plist</code> (for iOS) files.</li>
    <li>Run the app:</li>
    <pre><code>flutter run</code></pre>
</ol>

<h2>Usage</h2>
<ul>
    <li><strong>Login:</strong> Users can log in with their registered email and password.</li>
    <li><strong>Signup:</strong> New users can register with a valid email and password.</li>
    <li><strong>Home Page:</strong> After logging in, users will be directed to the home page displaying a list of products.</li>
</ul>

<h2>Contributing</h2>
<p>Contributions are welcome! Please fork the repository and create a pull request for any enhancements or bug fixes.</p>

