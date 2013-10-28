from robot.api import logger
try:
    from svg.charts import bar
except ImportError:
    logger.error('Python library svg.charts not present! Perform "sudo pip install svg.charts"')

class Chart:
    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'

    fields = ['Internet', 'TV', 'Newspaper', 'Magazine', 'Radio']
    
    def __init__(self):
        self._value_list = {}

    def add_to_chart(self, title, *values):
        if not title in  self._value_list:
             self._value_list[title] = []
        self._value_list[title] += [ values ]


    def _vertical_bars(self, title, x_axis, y_axis):

        try:
            x_labels = map(lambda dataset: dataset[x_axis], self._value_list.values()[0])

            g = bar.VerticalBar(x_labels)

            g.stack = 'side'
            g.scale_integers = True
            g.width, g.height = 640,480
            g.graph_title = title
            g.show_graph_title = True
            
            for legend, dataset_seq in   self._value_list.iteritems():
                y_values = map(lambda four: int(four[y_axis]), dataset_seq)
                g.add_data({'data': y_values, 'title': legend})

            return g.burn()

        except NameError, e:
            return '<svg xmlns="http://www.w3.org/2000/svg" version="1.1"  width="640" viewBox="0 0 640 480" height="480"><text x="10" y="20" font-size="18" style="fill:red;"><tspan x="10" y="45">Warning: failed to generate SVG chart diagram.</tspan><tspan x="10" y="85">Missing python library svg.charts, perform:</tspan> <tspan x="10" y="125">sudo pip install svg.charts</tspan> </text> </svg>'
 

    def print_chart(self, title, x_axis=0, y_axis=1):
        
        htmlChart = self._vertical_bars(title, int(x_axis), int(y_axis))
        logger.info(htmlChart, html=True)


