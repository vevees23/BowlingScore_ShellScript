<?php
/**
 * The template for displaying the front page
 *
 * @package WooCommerce_Flat_Theme
 */

get_header();
?>

	<main id="primary" class="site-main">

		<!-- Hero Section -->
		<section class="hero-section">
			<div class="container">
				<h1>Welcome to Our Awesome Store</h1>
				<p>Discover top-quality products with a seamless shopping experience.</p>
				<a href="#shop" class="btn-flat btn-secondary">Shop Now</a>
			</div>
		</section>

		<!-- Features Section with Flat Icons -->
		<section class="features-section">
			<div class="feature-box">
				<div class="flat-icon">
					<i class="fas fa-shipping-fast"></i>
				</div>
				<h3>Fast Shipping</h3>
				<p>We deliver your products quickly and reliably to your doorstep.</p>
			</div>

			<div class="feature-box">
				<div class="flat-icon">
					<i class="fas fa-shield-alt"></i>
				</div>
				<h3>Secure Payments</h3>
				<p>Your transactions are 100% secure with our trusted payment gateways.</p>
			</div>

			<div class="feature-box">
				<div class="flat-icon">
					<i class="fas fa-undo"></i>
				</div>
				<h3>Easy Returns</h3>
				<p>Not satisfied? Return your items within 30 days hassle-free.</p>
			</div>

			<div class="feature-box">
				<div class="flat-icon">
					<i class="fas fa-headset"></i>
				</div>
				<h3>24/7 Support</h3>
				<p>Our dedicated support team is here to help you anytime you need.</p>
			</div>
		</section>

		<!-- WooCommerce Products Section -->
		<section id="shop" class="products-section" style="padding: 60px 20px;">
			<div class="container" style="text-align:center;">
				<h2 style="margin-bottom: 40px; font-size: 32px; color: #2c3e50;">Featured Products</h2>
				<?php
				if ( class_exists( 'WooCommerce' ) ) {
					// Output WooCommerce shortcode for recent products
					echo do_shortcode( '[recent_products per_page="4" columns="4"]' );
				} else {
					echo '<p>Please install and activate WooCommerce to see products here.</p>';
				}
				?>
			</div>
		</section>

	</main><!-- #main -->

<?php
get_footer();
