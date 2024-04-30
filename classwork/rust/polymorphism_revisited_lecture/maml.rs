trait Element {
    fn to_html(&self) -> String;
}

struct Document {
    elements: Vec<Box<dyn Element>>,
}

impl Document {
    fn new() -> Self {
        Document {
            elements: Vec::new(),
        }
    }

    fn add(&mut self, element: Box<dyn Element>) {
        self.elements.push(element)
    }

    fn generate(&self) -> String {
        let mut html = String::new();
        html.push_str("<html>\n<body>\n");
        for element in self.elements.iter() {
            html.push_str(&element.to_html());
        }
        html.push_str("\n</body>\n</html>\n");
        html
    }
}

struct Heading {
    text: String,
}

impl Element for Heading {
    fn to_html(&self) -> String {
        format!("<h1>{}</h1>", self.text)
    }
}

struct Image {
    url: String,
}

impl Element for Image {
    fn to_html(&self) -> String {
        format!("<img src=\"{}\">", self.url)
    }
}

fn main() {
    let mut doc = Document::new();
    doc.add(Box::new(Heading { text: "AI Arranged My Marriage".to_string() }));
    doc.add(Box::new(Image { url: "couple.jpg".to_string() }));
    println!("{}", doc.generate());
}