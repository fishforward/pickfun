$( function()
{
	var config =
	{
		stars: 'images/stars-2.png',
		rating_callback: null,
		tooltips: '#social li, ul.social li, .hire-me, .hire-me-2, .ads, #portfolio li',
		tooltips2: 'ul.images li',
		slide: 500,
		boxshadow_fix: '.news,.popular,.articles-nav,.tabs .content,.featured.news,.ads li > a,.ad a,.comments dt span,.comments li > div,div > .comment form,.news > li > img,.further-reading,.section-tail,.tooltip span'
	};
	
	var mouse =
	{
		x: 0,
		y: 0
	};
	
	$(document).mousemove( function(event)
	{
		mouse.x = event.pageX;
		mouse.y = event.pageY;

	});
	
	$('#social,#aside div.tabs,div.rating,div.featured,.hire-me,.hire-me2').addClass('js');
	
	var version = $.browser.version.split('.');
	
	if ($.browser.msie || ($.browser.mozilla && version[0] < 2 && version[1] <= 8) || $.browser.opera)
	{
		$(config.boxshadow_fix).addClass('alt-border');
	}
	
	// TOOLTIPS BEGIN
	
	$(config.tooltips).hover( function(event)
	{
		$tooltip = $(this).children('div').eq(0);
		$tooltip.show();
	}, function()
	{
		$tooltip = $(this).children('div').eq(0);
		$tooltip.hide();
	});
	
	$(config.tooltips).mousemove( function(event)
	{
		$this = $(this);
		$tooltip = $(this).children('div');
		
		$tooltip.css
		({
			'top': event.pageY - $this.offset().top + 15,
			'right': $this.offset().left - event.pageX + $this.width() - 10
		});
	});
	
	$(config.tooltips2).hover( function(event)
	{
		index = $(this).parent('ul.images').children('li').index($(this));
		
		$tooltip = $(this)
			.parents('div.featured')
			.children('ul.tooltips')
			.children('li')
		.eq(index).children('div');
		
		
		
		$tooltip.show();
	}, function()
	{
		index = $(this).parent('ul.images').children('li').index($(this));
		
		$tooltip = $(this)
			.parents('div.featured')
			.children('ul.tooltips')
			.children('li')
		.eq(index).children('div');
		
		$tooltip.hide();
	});
	
	$(config.tooltips2).mousemove( function(event)
	{
		$this = $(this);
		index = $this.parent('ul.images').children('li').index($(this));
		$tooltip = $(this)
			.parents('div.featured')
			.children('ul.tooltips')
			.children('li')
		.eq(index).children('div');
		
		$tooltip.css
		({
			'top': event.pageY - $this.parents('div.featured').offset().top + 15,
			'left': event.pageX - $this.parents('div.featured').offset().left - $tooltip.width() + 10
		});
	});
	
	//TOOLTIPS END
	
	// SIDEBAR TABS BEGIN
	
	$tabs = $('div.tabs');
	$nav = $('div.tabs ul.nav li');
	$content = $('div.tabs ul.content > li');
	$map = $content.children('ul.map').children('li');
	
	if ($('div.tabs ul.nav li.current').length == 0)
	{
		$nav.eq(0).addClass('current');
	}
	
	$nav.click( function()
	{
		$nav = $('div.tabs ul.nav li');
		var index = $nav.index($(this));
		
		$nav
			.removeClass('current')
			.eq(index)
		.addClass('current');
		
		$content
			.hide()
			.eq(index)
		.show();
		
		if ($content.eq(index).children('ul.map').length > 0)
		{
			check_map($content, index);
		}
		
		return false;
	});
	
	$('ul.map > li > a').click( function()
	{
		$map = $('ul.map');
		$map_category = $map.children('li');
		$map_items = $map_category.children('ul');
		
		var index = $map_category.index($(this).parent('li'));

		$map_category.removeClass('current');
		$(this)
			.parent('li')
		.addClass('current');
		
		$map_items.hide().eq(index).show();
		
		if ($map.height() < $map_items.eq(index).height())
		{
			$map.height($map_items.eq(index).height())
		} else
		{
			$map.height('auto');
		}
		
		return false;
	});
	
	function check_map(content, selected_tab)
	{
		content
			.hide()
			.eq(selected_tab)
		.show();
		
		$map = content.eq(selected_tab).children('ul.map');
		
		if ($map.length > 0)
		{
			$map_category = $map.children('li');
			$map_items = $map_category.children('ul');
			
			var index = $map_category.index($map.children('li.current'));
			
			if (index == -1)
			{
				index = 0;
				$map_category.eq(0).addClass('current');
			}
			
			$map_items
				.hide()
				.eq(index)
			.show();
			
			if ($map_items.eq(index).height() > $map.parent().height())
			{
				$map.parent().height($map_items.eq(index).height());
			}
		}
	}
	
	check_map($content, $nav.index($('div.tabs ul.nav li.current')));
	
	// SIDEBAR TABS END
	
	// BACK TO TOP LINK BEGIN
	
	$('p.back-to-top a').click( function()
	{
		$('html,body').animate(
		{
			'scrollTop': '0px'
		}, 300);
		
		return false;
	});
	
	// BACK TO TOP LINK END
	
	// FEATURED IMAGES BEGIN
	
	$('div.featured ul.images')
		.css('position', 'absolute')
	.wrap
	(
		$('<p />')
			.addClass('featured-wrapper')
		.css
		({
			'top': 0,
			'left': 0,
			'position': 'relative',
			'overflow': 'hidden',
			'margin': 0,
			'padding': 0,
			'width': ($('div.featured').hasClass('portfolio') ? 391 : 553),
			'height': $('div.featured ul.images').outerHeight()
		}).show()
	);

	$('div.featured > .featured-wrapper').each( function()
	{
		$featured_images = $(this).children('ul.images').children('li');
		$featured_nav = $(this).children('ul.nav');
		//$featured_images.css('position', 'absolute');
		
		$(this).css
		({
			'width': ($(this).parent('div.featured').hasClass('portfolio') ? 391 : 553),
			'height': $(this).children('ul.images').outerHeight()
		});
		
		if ($featured_images.length > 1)
		{
			if ($featured_nav.length == 0)
			{
				$(this).append
				(
					$('<ul />')
						.append
						(
							$('<li />')
								.addClass('prev')
							.append
							(
								$('<a />').attr('href', '#prev')
							)
						).append(
							$('<li />')
								.addClass('next')
							.append(
								$('<a />').attr('href', '#next')
							)
						)
					.addClass('nav')
				);
			}
		}
	});
	
	$('div.featured ul.nav li').live('click', function()
	{
		$featured_images = $(this).parent('ul').prev('ul.images').children('li');
		var size = $featured_images.length;
		
		$featured_images = $(this).parent('ul').prev('ul.images');

		var current = Math.abs($featured_images.position().left/$featured_images.parent('.featured-wrapper').outerWidth());

		if ($(this).hasClass('prev'))
		{
			current--;
					
			if (current < 0)
			{
				current = 0
			} else
			{
				$featured_images.animate
				({
					'left': '+=' +$featured_images.parent('.featured-wrapper').outerWidth()
				}, config.slide);	
			}
		} else if ($(this).hasClass('next'))
		{
			current++;
			
			if (current > size-1)
			{
				current = size-1;
			} else
			{
				$featured_images.animate
				({
					'left': '-=' + $featured_images.parent('.featured-wrapper').outerWidth()
				}, config.slide);	
			}
		}
		
		return false;
	});
	
	// FEATURED IMAGES END

	// RATING BEGIN
	
	$rating = $('div.rating');
	
	$rating.each( function()
	{
		$(this).children('form').after
		(
			$('<ul />').addClass('star')
		);
		
		$stars = $(this).children('ul.star');
		
		for (var i = 0; i < 5; i++)
		{
			description = (i == 0 ? ' star' : ' stars');
			
			$stars.append
			(
				$('<li />').append
				(
					$('<a />').append
					(
						$('<img />').attr
						({
							'src': config.stars,
							'alt': (i+1) + description,
							'title': (i+1) + description
						})
					)
				).hover( function()
				{
					var index = $('div.rating ul li').index($(this));
					
					$(this)
						.addClass('on')
						.prevAll('li')
					.addClass('on');
					
					$(this)
						.parent('ul')
						.parent('div')
					.append
					(
						$('<p />').text((index+1) + (index == 0 ? ' star' : ' stars'))
					);
				}, function()
				{
					$(this)
						.removeClass('on')
						.prevAll('li')
					.removeClass('on');
					
					$(this)
						.parent('ul')
						.parent('div')
						.children('p:last-child')
					.remove();
				}).click( function()
				{
					$(this)
						.removeClass('rated')
						.addClass('rated')
						.prevAll('li')
					.addClass('rated');
					
					$(this)
						.parent('ul')
						.parent('div')
						.children('p:last-child')
					.remove();
					
					var rate = 1 + $(this).prevAll('li').length;
					
					$form = $(this)
						.parent('ul')
					.prev('form');
					
					$select = $form
						.children('fieldset')
					.children('select');
					
					$form.submit( function()
					{
						
						return false;
					});
				})
			);
		}
	});
	
	// RATING END
	
	// HEADER NAV BEGIN
	
	$nav = $('div#header > ul#nav > li');
	$nav_current = $('div#header > ul#nav > li.current');
	$subnav = $nav.children('ul');
	$subnav.hide();
	
	if ($nav_current.length == 0)
	{
		var index = 0;
		
		$nav
			.eq(index)
			.addClass('current')
			.children('ul')
		.show();
	} else
	{
		var index = $nav.index($nav_current);
		
		$nav
			.eq(index)
			.children('ul')
		.show();
	}
	
	$nav.hover( function()
	{
		$nav = $('div#header > ul#nav > li');
		$nav_current = $('div#header > ul#nav > li.current');
		$subnav = $nav.children('ul');
		
		$nav
			.removeClass('current')
			.children('ul')
			.not($(this).children('ul'))
		.fadeOut();
		
		$(this)
			.addClass('current')
			.children('ul')
		.fadeIn();
	}, function() {});
	
	// HEADER NAV END
	
	// CREATO BOX BEGIN
	$.fn.creatobox = function(config)
	{
		$slide = $(this);
		
		config = $.extend
		({
			fade_in: 1500,
			fade_out: 1500,
			label: 'Hire me',
			url: '',
			wrapper: 'creato-wrapper',
			lightbox: 'lightbox',
			single: true,
			show_button: true
		}, config);
		
		$(this).each( function()
		{
			$(this).click( function(event)
			{
				$wrapper = $('<div />').attr('id', config.wrapper).hide();
				
				$wrapper.css
				({
					'background': '#000',
					'position': 'absolute',
					'left': $(window).scrollLeft(),
					'top': $(window).scrollTop(),
					'width': $(window).width(),
					'height': $(window).height(),
					'z-index': 1337,
					'opacity': 0
				});
				
				$wrapper.click( function(event)
				{
					$(this).fadeOut(config.fade_out, function()
					{
						$(this).remove();
					});
					
					$('#' + config.lightbox).fadeOut(config.fade_out, function()
					{
						$(this).remove();
					});
					
					event.preventDefault();
					
					return false;
				});

				$wrapper.appendTo('body').show().fadeTo(1000, 0.7);
					
				$lightbox = $('<div />').attr('id', config.lightbox);
				
				$lightbox.css
				({
					'z-index': 1338,
					'position': 'absolute',
					'left': $(window).scrollLeft() + $(window).width()/2 - $(this).outerWidth()/2,
					'top': $(window).scrollTop() + $(window).height()/2 - $(this).outerHeight()/2
				});
				
				var title = $(this).find('img').attr('alt');
				var details = $(this).children('div').children('span').children('a').attr('href');
				
				if ($(this).children('div').length == 0)
				{
					details = '';
				}
				
				var img = $(this).children('a').attr('href');
				var first_img = true;
				
				//$lightbox.html('<h2><a href="' + details + '">' + title + '</a></h2><ul><li><a href="' + img + '"><img src="' + img + '" alt="desc" /></a></li></ul><ul class="nav"><li class="prev"><a href="#prev">prev</a></li><li class="next"><a href="#next">next</a></li></ul><a class="more" href="' + details + '">' + config.label + '</a><a class="close" href="#close">Close</a>');
				
				$lightbox.append
				(
					$('<h2 />').append
					(
						$('<a />')
							.attr('href', details)
						.text(title)
					)
				).append
				(
					$('<ul />')
					.addClass('items')
				).append
				(
					$('<a />')
						.addClass('more')
						.attr('href', details)
					.text(config.label)
				).append
				(
					$('<a />')
						.addClass('close')
						.attr('href', '#close')
						.text('Close')
					.click( function(event)
					{
						$('#' + config.wrapper).fadeOut(config.fade_out, function()
						{
							$(this).remove();
						});
						
						$('#' + config.lightbox).fadeOut(config.fade_out, function()
						{
							$(this).remove();
						});
						
						event.preventDefault();
						
						return false;
					})
				);
			
				if (config.label == 'See more details')
				{
					$lightbox.find('a.more').addClass('long').text(config.label);
				}
				
				if (config.label == 'Hire me')
				{
					$lightbox.find('a.more').attr('href', config.url).text(config.label);
				}
					
				$lightbox.appendTo('body').hide().fadeIn();
				$images = $(this).parent('ul').children('li');
				
				if (config.single || $images.length == 1)
				{
					$lightbox.children('ul.items').append
					(
						$('<li />').append
						(
							$('<img />').load( function()
							{
								$img = $(this);
								
								$lightbox.css
								({
									'top': $(window).scrollTop() + $(window).height()/2 - $img.outerHeight()/2,
									'left': $(window).scrollLeft() + $(window).width()/2 - $img.outerWidth()/2
								});

								$lightbox.children('ul.items').css
								({
									'width': $img.outerWidth(),
									'height': $img.outerHeight(),
									'position': 'relative'
								});
								
								$(window).scroll();
							}).attr('src', img + '?' + (new Date()).getTime())
						)
					);
				} else
				{
					$images.each( function()
					{
						$img = $(this).children('img');
						img_path = $(this).children('a').attr('href');
						img_alt = $(this).children('img').attr('alt');
						
						$lightbox.children('ul.items').css
						({
							'position': 'relative'
						}).append
						(
							$('<li />').append
							(
								$('<img />').attr('alt', img_alt).load( function()
								{
									$this = $(this);
									
									if (first_img)
									{
										$img.parent('li').show();
										
										$lightbox.children('ul.items').css
										({
											'width': $this.outerWidth(),
											'height': $this.outerHeight()
										});
										
										/*$lightbox.css
										({
											'top': $(window).scrollTop() + $(window).height()/2 - $this.outerHeight()/2,
											'left': $(window).scrollLeft() + $(window).width()/2 - $this.outerWidth()/2,
										});*/
										
										$(window).scroll();
										
										first_img = false;
									} else
									{
										$(this).parent('li').hide();
									}
								}).attr('src', img_path + '?' + (new Date()).getTime())
							).css
							({
								'position': 'absolute'
							})
						);
					});
					
					$lightbox.children('ul.items').children('li').eq(0).show();
					
					$lightbox.children('ul.items').after
					(
						$('<ul />')
							.addClass('nav')
						.append
						(
							$('<li />')
								.addClass('prev')
							.append
							(
								$('<a />')
									.attr('href', '#prev')
								.click( function(event)
								{
									$item = $lightbox.children('ul.items').children('li');
									var current = $item.index($lightbox.children('ul.items').children('li:visible'));
									var prev = current-1;
									
									if (prev < 0)
									{
										prev = $item.length-1;
									}

									$item.eq(current).fadeOut();
									$item.eq(prev).fadeIn();
									$lightbox.children('h2').children('a').text($item.eq(next).children('img').attr('alt'));
									
									$item.parent('ul').animate
									({
										'width': $item.eq(prev).children('img').outerWidth(),
										'height': $item.eq(prev).children('img').outerHeight()
									});
									
									$lightbox.animate
									({
										'left': $(window).scrollLeft() + $(window).width()/2 - $item.eq(prev).outerWidth()/2,
										'top': $(window).scrollTop() + $(window).height()/2 - $item.eq(prev).outerHeight()/2
									});
									event.preventDefault();
									return false;
								})
							)
						).append
						(
							$('<li />')
								.addClass('next')
							.append
							(
								$('<a />')
									.attr('href', '#next')
								.click( function(event)
								{
									$item = $lightbox.children('ul.items').children('li');
									var current = $item.index($lightbox.children('ul.items').children('li:visible'));
									var next = current+1;
									
									if (next > $item.length-1)
									{
										next = 0;
									}

									$item.eq(current).fadeOut();
									$item.eq(next).fadeIn();
									$lightbox.children('h2').children('a').text($item.eq(next).children('img').attr('alt'));
									
									$item.parent('ul').animate
									({
										'width': $item.eq(next).children('img').outerWidth(),
										'height': $item.eq(next).children('img').outerHeight()
									});
									
									$lightbox.animate
									({
										'left': $(window).scrollLeft() + $(window).width()/2 - $item.eq(next).outerWidth()/2,
										'top': $(window).scrollTop() + $(window).height()/2 - $item.eq(next).outerHeight()/2
									});
									
									event.preventDefault();
									
									return false;
								})
							)
						)
					);
				}
				
				if ( ! config.show_button)
				{
					$lightbox.find('a.more').remove();
				}

				$(window).scroll( function()
				{
					$('#' + config.wrapper).css
					({
						'top': $(window).scrollTop(),
						'left': $(window).scrollLeft()
					});

					$('#' + config.lightbox).css
					({
						'top': $(window).scrollTop() + $(window).height()/2 - $('#' + config.lightbox).find('li:visible').outerHeight()/2,
						'left': $(window).scrollLeft() + $(window).width()/2 - $('#' + config.lightbox).find('li:visible').outerWidth()/2
					});
				});
				
				$(window).resize( function()
				{
					$('#' + config.wrapper).css
					({
						'width': $(window).width(),
						'height': $(window).height()
					});
				});
				
				event.preventDefault();
			
				return false;
			});
		});
		
		return this;
	};
	
	$('#portfolio li,div.portfolio ul.images li,div.featured ul.post li').click( function() { return false; });
	$('div.portfolio ul.images li').creatobox({ label: 'Hire me', url: 'hire-me.html', single: false });
	$('ul#portfolio li').creatobox({ label: 'See more details' });
	$('div.featured ul.post li').creatobox({ single: false, show_button: false });
	
	
	// CREATO BOX END
	
	// FROM VALIDATION BEGIN
	errors = 0;
	
	function is_valid_email(email)
	{
		return /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email);
	}

	$('#name,#message').blur( function()
	{
		$(this).removeClass('valid');
		
		if ($(this).val() == '')
		{
			$(this).addClass('error');
		} else
		{
			$(this).removeClass('error').addClass('valid');
		}
	});
	
	$('#email').blur( function()
	{
		$(this).removeClass('valid');
		
		if ( ! is_valid_email($(this).val()))
		{
			$(this).addClass('error');
		} else
		{
			$(this).removeClass('error').addClass('valid');
		}
	});
	
	$('#comment #submit').click( function()
	{
		$('#name,#message,#email').blur();
		
		if ($('#contact input.error').length > 0)
		{
			return false;
		}
	});
	
	// FROM VALIDATION END
});
