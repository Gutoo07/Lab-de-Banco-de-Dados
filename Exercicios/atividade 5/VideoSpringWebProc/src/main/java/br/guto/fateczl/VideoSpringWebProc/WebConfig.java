package br.guto.fateczl.VideoSpringWebProc;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@ComponentScan(basePackages = "br.guto.fateczl.VideoSpringWebProc")
public class WebConfig implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/WEB-INF/resources"); //localizacao dos CSS's
	}
	
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("index.jsp"); /*Eu tive 2 ou 3 erros relacionados a ausencia do .jsp no nome das views, 
		entao fui debugando e coloquei o .jsp em alguns lugares que citavam a index ou a cliente.jsp, e enfim o programa rodou.
		Nao sei como funciona, mas talvez a minha application properties nao esteja sendo reconhecida ou eu configurei errado,
		mesmo tendo assistido o video auxiliar varias vezes! */
	}
}
