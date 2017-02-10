import React, { Component } from 'react';

class VoteButton extends Component {
  constructor(props) {
    super(props);
    this.state = {
      vote_tally: this.props.comment.vote_tally
    };
    this.handleUpvote = this.handleUpvote.bind(this);
    this.handleDownvote = this.handleDownvote.bind(this);
  }

  componentDidMount() {
    fetch(`/api/v1/comments/${this.props.comment}/votes.json`)
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} ($response.statusText)`,
            error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        this.setState({vote_tally: body});
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  handleUpvote(event) {
    let data = {
      voted: true
    };
    let jsonStringData = JSON.stringify(data);
    fetch(`/api/v1/comments/${this.props.comment}/votes.json`,
      { method: 'post',
        body: jsonStringData,
        credentials: 'include'
      })
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          let errorMessage = `${response.status} ($response.statusText)`,
            error = new Error(errorMessage);
            throw(error);
        }
      })
      .then(data => {
         this.setState({ vote_tally: data });
      })
    .catch(error => console.error(`Error in fetch: ${error.message}`));
}

  handleDownvote(event) {
    let data = {
        voted: false
    };
    let jsonStringData = JSON.stringify(data);
    fetch(`/api/v1/comments/${this.props.comment}/votes.json`,
      { method: 'post',
        body: jsonStringData,
        credentials: 'include'
      })
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          let errorMessage = `${response.status} ($response.statusText)`,
            error = new Error(errorMessage);
            throw(error);
        }
      })
      .then(data => {
         this.setState({ vote_tally: data });
      })
    .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  render() {
    return(
      <div>
        <div onClick={this.handleUpvote}>
          <i className="fa fa-caret-up" aria-hidden="true"></i>
        </div>
        <div> {this.state.vote_tally} </div>
        <div onClick={this.handleDownvote}>
          <i className="fa fa-caret-down" aria-hidden="true"></i>
        </div>
      </div>
    );
  }
}

export default VoteButton;
