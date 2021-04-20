help:
	@echo "Generate HTML from a Bikeshed source document:"
	@echo "  make spec    Generate HTML"
	@echo "  make watch   Generate HTML each time the source changes"
	@echo "  make dist    Generate HTML in dist directory"

spec:
	docker run -v "`pwd`:/spec" -w /spec netwerkdigitaalerfgoed/bikeshed:1.7.0

watch:
	docker run -v "`pwd`:/spec" -w /spec netwerkdigitaalerfgoed/bikeshed:1.7.0 sh -c "bikeshed watch"

PAGES = index.html notify-scenario-1.html

dist: $(PAGES)

%.html : %.bs
	curl -s https://api.csswg.org/bikeshed/ -F file=@$< -F force=1 > $@

clean:
	rm -f $(PAGES)
